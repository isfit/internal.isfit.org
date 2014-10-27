class SppArticle < ActiveRecord::Base
  attr_accessor :x1, :y1, :x2, :y2, :x1, :y1_1, :x2_1, :y2_1, :x1_1, :y1_2, :x2_2, :y2_2,:x1_2, :photo_id

  has_attached_file :spp_article_image, styles:  {
    front_large: {geometry: "620x365#", processors: [:cropper] },
    front_small: {geometry: "220x131#", processors: [:cropper_half] },
    article: {geometry: "447x346#", processors: [:cropper_spp_one_third] }
    }
  validates_attachment_content_type :spp_article_image, :content_type => /\Aimage\/.*\Z/

  def cropping?
    true
  end

  def reprocess_photos
    self.spp_article_image.reprocess!
  end

end
