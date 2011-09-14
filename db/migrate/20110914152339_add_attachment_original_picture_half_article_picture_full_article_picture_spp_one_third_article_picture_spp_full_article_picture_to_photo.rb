class AddAttachmentOriginalPictureHalfArticlePictureFullArticlePictureSppOneThirdArticlePictureSppFullArticlePictureToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :original_picture_file_name, :string
    add_column :photos, :original_picture_content_type, :string
    add_column :photos, :original_picture_file_size, :integer
    add_column :photos, :original_picture_updated_at, :datetime
    add_column :photos, :half_article_picture_file_name, :string
    add_column :photos, :half_article_picture_content_type, :string
    add_column :photos, :half_article_picture_file_size, :integer
    add_column :photos, :half_article_picture_updated_at, :datetime
    add_column :photos, :full_article_picture_file_name, :string
    add_column :photos, :full_article_picture_content_type, :string
    add_column :photos, :full_article_picture_file_size, :integer
    add_column :photos, :full_article_picture_updated_at, :datetime
    add_column :photos, :spp_one_third_article_picture_file_name, :string
    add_column :photos, :spp_one_third_article_picture_content_type, :string
    add_column :photos, :spp_one_third_article_picture_file_size, :integer
    add_column :photos, :spp_one_third_article_picture_updated_at, :datetime
    add_column :photos, :spp_full_article_picture_file_name, :string
    add_column :photos, :spp_full_article_picture_content_type, :string
    add_column :photos, :spp_full_article_picture_file_size, :integer
    add_column :photos, :spp_full_article_picture_updated_at, :datetime
  end

  def self.down
    remove_column :photos, :original_picture_file_name
    remove_column :photos, :original_picture_content_type
    remove_column :photos, :original_picture_file_size
    remove_column :photos, :original_picture_updated_at
    remove_column :photos, :half_article_picture_file_name
    remove_column :photos, :half_article_picture_content_type
    remove_column :photos, :half_article_picture_file_size
    remove_column :photos, :half_article_picture_updated_at
    remove_column :photos, :full_article_picture_file_name
    remove_column :photos, :full_article_picture_content_type
    remove_column :photos, :full_article_picture_file_size
    remove_column :photos, :full_article_picture_updated_at
    remove_column :photos, :spp_one_third_article_picture_file_name
    remove_column :photos, :spp_one_third_article_picture_content_type
    remove_column :photos, :spp_one_third_article_picture_file_size
    remove_column :photos, :spp_one_third_article_picture_updated_at
    remove_column :photos, :spp_full_article_picture_file_name
    remove_column :photos, :spp_full_article_picture_content_type
    remove_column :photos, :spp_full_article_picture_file_size
    remove_column :photos, :spp_full_article_picture_updated_at
  end
end
