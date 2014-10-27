class Article < ActiveRecord::Base
  validates :title, :presence => true
  validates :body, :presence => true
  belongs_to :user
  has_attached_file :article_image,
    styles: {thumb: "200x200#", original: "400x400>"}
  validates_attachment_content_type :article_image, :content_type => /\Aimage\/.*\Z/
  has_many :articles_attendings

  self.per_page = 10

  def attending_count
    self.articles_attendings.count
  end

  def user_attending? user
    self.articles_attendings.where(user_id: user.id).any?
  end

  def attending_users
    self.articles_attendings.map do |attendings|
      User.find(attendings.user_id).full_name
    end
  end
end
