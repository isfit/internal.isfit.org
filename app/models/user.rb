# -*- coding: utf-8 -*-
# == User
#
# Hovedmodell for en bruker av systemet. Inneholder hjelpemetoder som kan
# brukes til å hente attributter, seksjoner, gjenger etc. av en bruker

class User < ActiveRecord::Base
  
  validates :password, length: {minimum: 8}, allow_blank: true
  self.primary_key = :id
  has_secure_password
  has_many :groups, through: :positions
  has_many :room_bookings
  has_many :kvitters
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :positions

  attr_readonly :username, :ldap_id, :email

   has_attached_file :profile_picture, { 
     :url => "/system/:hash.:extension",
     :hash_secret => "kakekakekakemonster",
     styles:  {
      large: {geometry: "180x180#"},
      small: {geometry: "50x50#"}
      }
   }

  # Return full name of user
  def full_name
    "#{given_name} #{family_name}"
    #"#{given_name} #{family_name}".split(/\s+/).map{|n| n.capitalize}.join(' ')
  end

  #Return full name reversed of user
  def full_name_reversed
    "#{family_name}, #{given_name}"
  end

  def initiales
    full_name.split(/ /).map{|n| n[0]}.join('.')
  end

  # Returns all users in a given festival
  def self.in_festival(year=2013, sort_columns="family_name, given_name")
    id = Festival.find_by_year(year).id
    joins(:positions => :groups).joins("LEFT OUTER JOIN sections ON sections.id = groups.section_id").where("groups.festival_id = ? OR sections.festival_id = ?", id,id).group("users.id").order(sort_columns)
  end

  # Returns a number of random users from a given festival
  def self.random(year=2013, limit=5)
    self.in_festival(year,"RAND()").limit(limit).where("users.id > 1")
  end

  def name_reversed
    "#{self.family_name}, #{self.given_name}"
  end


  #Return if user has role
  def role?(r)
    role = Role.where(name:r).first
    roles.include?(role)
  end
 
  def changeLdapPassword(pass)
    require 'net/ldap'
    require 'openssl'
    require 'iconv'
    ldap = Net::LDAP::new
    password = YAML::load(File.open('config/password.yml'))
    treebase = "dc=isfit,dc=org"
    filters = Net::LDAP::Filter.eq("uid", self.username)
    dn = ldap.search(:base => treebase, :filter => filters).first.dn
    auth = { :method => :simple, :username => "cn=password,dc=isfit,dc=org", :password => password }
    Net::LDAP.open(:auth => auth) do |ldap|
      ldap.replace_attribute dn, :userPassword, Net::LDAP::Password.generate(:md5,pass)
      # TODO iconv er deprecated bruk string#encoding etterhvert...
      ldap.replace_attribute dn, :sambaNTPassword, OpenSSL::Digest::MD4.hexdigest(Iconv.iconv("UCS-2", "UTF-8", pass).join).upcase
    end
  end
end
