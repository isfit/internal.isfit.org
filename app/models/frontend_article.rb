class FrontendArticle < ActiveRecord::Base
  attr_accessor :x1, :y1, :x2, :y2, :x1, :y1_1, :x2_1, :y2_1, :x1_1, :y1_2, :x2_2, :y2_2,:x1_2, :photo_id
  after_update :reprocess_photos
  before_save :set_byline

  has_attached_file :frontend_article_image, styles:  {
    front_large: {geometry: "346x154#", processors: [:cropper] },
    front_small: {geometry: "220x131#", processors: [:cropper_half] },
    article: {geometry: "447x346#", processors: [:cropper_spp_one_third] }
  }
 
  def cropping?
    true
  end

  private

  def set_byline
      user = User.find(self.byline_user_id)
      self.byline = "<a href=\"mailto:#{user.username}@isfit.org\">#{user.full_name}</a>"
  end

  def reprocess_photos
    self.frontend_article_image.reprocess!
  end

end
