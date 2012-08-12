class Workshop < ActiveRecord::Base
  belongs_to :user

  attr_accessor :image_file_name, :image_content_type, :image_file_size, :image_updated_at

  has_attached_file :workshop_image,
    :styles => {
    :original => "940x480>",
    :thumb => "120x230>"
  }
end
