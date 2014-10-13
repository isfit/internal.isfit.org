class Kvitter < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :hashtags

  has_many :awesomes

  validates :message, :presence => true
  validate :unique_message_from_user
  
  self.per_page = 10

  def username
    self.user.username
  end

  def awesome_count
  	self.awesomes.count
  end

  def user_full_name
    self.user.given_name + " " + self.user.family_name
  end

  def user_image
    if self.user.profile_picture?
      self.user.profile_picture.url(:small)
    else
      nil
    end
  end

  private
    def unique_message_from_user
      unless Kvitter.where(user_id: self.user_id, message: self.message).empty?
        errors.add(:base, "Can't kvitter the same message twice")
      end
    end
end
