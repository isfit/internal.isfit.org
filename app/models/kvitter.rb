class Kvitter < ActiveRecord::Base
  belongs_to :user

  validates :message, :presence => true
  
  self.per_page = 10

  def username
    self.user.username
  end

end
