class Kvitter < ActiveRecord::Base
  belongs_to :user

  has_many :awesomes

  validates :message, :presence => true
  
  self.per_page = 10

  def username
    self.user.username
  end

  def awesome_count
  	self.awesomes.count
  end

end
