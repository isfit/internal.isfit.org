class User < ActiveRecord::Base
  # == User
  #
  # Hovedmodell for en bruker av systemet. Inneholder hjelpemetoder som kan
  # brukes til å hente attributter, seksjoner, gjenger etc. av en bruker
  

  validates :password, length: {minimum: 8}
  set_primary_key :id
  has_secure_password
  has_many :groups, :through => :positions
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :positions

  attr_readonly :username, :ldap_id, :email


  #Return full name of user
  def full_name
    "#{given_name} #{family_name}"
  end

  #Return full name reversed of user
  def full_name_reversed
    "#{family_name}, #{given_name}"
  end

  #Return if user has role
  def role?(r)
    role = Role.where(name:r).first
    roles.include?(role)
  end
end
