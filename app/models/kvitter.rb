class Kvitter < ActiveRecord::Base
  belongs_to :user

  def username
    self.user.username
  end

end
