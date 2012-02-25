class Kvitter < ActiveRecord::Base
  belongs_to :user

  validates :message, :presence => true

  def username
    self.user.username
  end

end
