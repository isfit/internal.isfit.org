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

  def self.in_festival(year=2013, sort_columns="family_name, given_name")
    id = Festival.find_by_year(year).id
    joins(:positions => :groups).joins("LEFT OUTER JOIN sections ON sections.id = groups.section_id").where("groups.festival_id = ? OR sections.festival_id = ?", id,id).group("users.id").order(sort_columns)
  end




  #    id = Festival.find_by_year(year).id
#    users = User.includes(:positions => [:groups, {:groups => :section}]).where("sections.festival_id = #{id} OR groups.festival_id = #{id}").order(sort_columns)
#    return users
#  end
#  def self.in_festival(year=2013, sort_columns="family_name, given_name")
#    id = Festival.find_by_year(year).id
#    users = User.joins(:positions => :groups, :positions => [:groups => :section]).where("groups.festival_id = #{id} or sections.festival_id = #{id}").order(sort_columns).select("DISTINCT users.*")  
#    # Jeg spanderer pizza på dne som klarer å fikse denne
#    # User.joins(:positions => [:groups, {:groups => :festival}, {:groups => [:section, {:section => :festival}]}])
#    full_users = []
#    users.each do |u|
#      full_users << User.find(u.id)
#    end
#    return full_users
#  end

  def name_reversed
    "#{self.family_name}, #{self.given_name}"
  end


  #Return if user has role
  def role?(r)
    role = Role.where(name:r).first
    roles.include?(role)
  end
end
