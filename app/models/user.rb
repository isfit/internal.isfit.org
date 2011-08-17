class User < ActiveRecord::Base
  set_primary_key :id
  has_secure_password
  has_and_belongs_to_many :roles


  def full_name
    "#{given_name} #{family_name}"
  end

  def role?(r)
    role = Role.where(:name=>r).first
    role_abstraction.include?(role)
  end
end
