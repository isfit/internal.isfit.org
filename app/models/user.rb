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
  has_many :subscriptions
  has_many :who_am_is
  has_many :what_am_is

  attr_readonly :username, :ldap_id, :email

  has_attached_file :profile_picture, {
    :url => "/system/:hash.:extension",
    :hash_secret => "kakekakekakemonster",
    styles: {
      large: {geometry: "180x180#"},
      small: {geometry: "50x50#"}
    }
  }
  validates_attachment_content_type :profile_picture, :content_type => /\Aimage\/.*\Z/

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
  def self.in_festival(year=2015, sort_columns="family_name, given_name")
    id = Festival.find_by(year: year).id
    joins(:positions => :groups).joins("LEFT OUTER JOIN sections ON sections.id = groups.section_id").where("groups.festival_id = ? OR sections.festival_id = ?", id,id).group("users.id").order(sort_columns)
  end

  # Returns a number of random users from a given festival
  def self.random(year=2015, limit=5)
    self.in_festival(year,"RAND()").limit(limit).where("users.id > 1")
  end

  def name_reversed
    "#{self.family_name}, #{self.given_name}"
  end

  def id_hash
    Digest::MD5.hexdigest(self.id.to_s + Rails.application.secrets.secret_key_base)
  end

  #Return if user has role
  def role?(role)
    self.roles.any? { |r| r.name.underscore.to_sym == role }
  end

  def self.birthday_notify
    users_with_birthday = self.in_festival.birthday_users
    users_with_birthday.each do |user|
      age = Time.now.year - user.date_of_birth.year
      k = Kvitter.new
      k.user_id = 1
      k.message = "Internal gratulerer #{user.full_name} med #{age.to_s}-årsdagen. Hipp hurra!"
      k.save
    end
  end

  def self.birthday_users
    month = Time.now.month.to_s
    day   = Time.now.day.to_s

    month = '0'+month if month.length == 1
    day   = '0'+day   if day.length == 1

    self.where("date_of_birth LIKE '%#{month}-#{day}'")
  end

  def birthday?
    if self.date_of_birth
      Date.today.strftime("%m%d") == self.date_of_birth.strftime("%m%d")
    else
      false
    end
  end

  def changeLdapPassword(pass)
    require 'net/ldap'
    require 'openssl'
    require 'iconv'
    ldap = Net::LDAP::new
    password = Rails.application.secrets.ldap
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

  def hasLdapAccount?
    require 'net/ldap'
    require 'openssl'
    require 'iconv'
    ldap = Net::LDAP::new
    password = Rails.application.secrets.ldap
    treebase = "dc=isfit,dc=org"
    filters = Net::LDAP::Filter.eq("uid", self.username)
    user = ldap.search(:base => treebase, :filter => filters).first
    if user.nil?
      false
    else
      true
    end
  end

  def latest_position
    self.positions.last
  end
end
