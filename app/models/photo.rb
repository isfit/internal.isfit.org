class Photo < ActiveRecord::Base

  attr_accessor :x1, :y1, :x2, :y2, :x1, :y1_1, :x2_1, :y2_1, :x1_1, :y1_2, :x2_2, :y2_2, :x1_3, :y1_3, :x2_3, :y2_3  

  after_update :reprocess_photos
  has_attached_file :original_picture, styles:  {
    thumb: {geometry: "200x200#"}, 
    cropable: {geometry: "1000x1000>"},
    full_article: {geometry: "540x250#", processors: [:cropper] },
    half_article: {geometry: "260x340#", processors: [:cropper_half] },
    spp_one_third_article: {geometry: "210x310#", processors: [:cropper_spp_one_third] },
    spp_full_article: {geometry: "700x320#", processors: [:cropper_spp_full] }
    }
  validates_attachment_content_type :original_picture, :content_type => /\Aimage\/.*\Z/
#  has_attached_file :half_article_picture  
#  has_attached_file :full_article_picture, styles: {thumb: "200x200#", processors: [:cropper] }
#  has_attached_file :spp_one_third_article_picture 
#  has_attached_file :spp_full_article_picture 

  def cropping?
    !x1.blank?
  end

  def original_picture_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(original_picture.path(style))
  end

  private

  def reprocess_photos
    self.original_picture.reprocess!
  end
end
