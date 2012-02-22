class User < ActiveRecord::Base
  # == User
  #
  # Hovedmodell for en bruker av systemet. Inneholder hjelpemetoder som kan
  # brukes til å hente attributter, seksjoner, gjenger etc. av en bruker

  validates :password, length: {minimum: 8}
  set_primary_key :id
  has_secure_password
  has_many :groups, through: :positions
  has_many :room_bookings
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :positions

  attr_readonly :username, :ldap_id, :email

  # Return full name of user
  # Try statements if no name is given
  def full_name
    "#{given_name} #{family_name}"
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

  def name_reversed
    "#{self.family_name}, #{self.given_name}"
  end


  #Return if user has role
  def role?(r)
    role = Role.where(name:r).first
    roles.include?(role)
  end
end
