class Kvitter < ActiveRecord::Base
  belongs_to :user

  validates :presence, :message

  def username
    self.user.username
  end

end
