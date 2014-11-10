class FrontendArticle < ActiveRecord::Base
  attr_accessor :x1, :y1, :x2, :y2, :x1, :y1_1, :x2_1, :y2_1, :x1_1, :y1_2, :x2_2, :y2_2,:x1_2, :photo_id
  before_save :set_byline

  has_attached_file :frontend_article_image, styles:  {
    frontpage_large: {geometry: "620x362#", processors: [:cropper] },
    article_large: {geometry: "940x480#", processors: [:cropper_half] }
  }
  validates_attachment_content_type :frontend_article_image, :content_type => /\Aimage\/.*\Z/

  def cropping?
    true
  end

  def reprocess_photos
    self.frontend_article_image.reprocess!
  end

  private

  def set_byline
      if self.byline_user_id
        user = User.find(self.byline_user_id)
        self.byline = "<a href=\"mailto:#{user.username}@isfit.org\">#{user.full_name}</a>"
      end
  end

end
