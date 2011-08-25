class User < ActiveRecord::Base
  set_primary_key :id
  has_secure_password
  has_many :groups, :through => :positions
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :positions

  def full_name
    "#{given_name} #{family_name}"
  end

  def role?(r)
    role = Role.where(name:r).first
    roles.include?(role)
  end
end
