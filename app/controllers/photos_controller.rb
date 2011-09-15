class PhotosController < ApplicationController

  def new
    @picture = Photo.new
  end

  # DELETE /photos/1
  # DELETE /photos/1.xml
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to(photos_url) }
      format.xml  { head :ok }
    end
  end

  def edit
    @photo = Photo.find_by_id(params[:id])
  end

  def update
    @photo =  Photo.find(params[:id])
    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html {redirect_to crop_photo_path(params[:tab], @photo) }
      else
        format.html { render :tab=> params[:tab], :action => "edit" }
      end
    end
  end


  def create
    @picture = Photo.new(params[:photo])
    @picture.save!

    respond_to do |format|
      format.html {redirect_to crop_photo_path(@picture) } 
    end
  end

  def show
    @picture = Photo.find(params[:id])

  end

  def crop
    @picture = Photo.find(params[:id])
    url = Rails.root.to_s+'/' + @picture.original_picture.url(:cropable)
    url.to_s.gsub!(/\?[1234567890]+/, "")
    @picurl = @picture.original_picture.url(:cropable)
    #unless File.exist?(url)
    #  @picurl = @picture.original_picture.url
    #end
  end

  def index
    @photos = Photo.order("created_at DESC")
    respond_to do |format|
      format.html
      format.js
    end
  end


  def crop_create
    @picture = Photo.find(params[:picture])
    url = Rails.root.to_s + "/public"+ @picture.original_picture.url(:cropable)
    url.gsub!(/\?[1234567890]+/, "")
    url = Rails.root.to_s + "/public"+ @picture.original_picture.url unless File.exist?(url)
    url.gsub!(/\?[1234567890]+/, "")
    logger.info(url)

    @full = resize(params[:x1],params[:y1],params[:x2],params[:y2],url, 1)
    logger.info(@full.inspect)
    #@half = resize(params[:x1_1],params[:y1_1],params[:x2_1],params[:y2_1],url, 2)
    #@spp_one_third = resize(params[:x1_2],params[:y1_2],params[:x2_2],params[:y2_2],url, 3)
    #@spp_full = resize(params[:x1_3],params[:y1_3],params[:x2_3],params[:y2_3],url, 4)
    @tmp_img = Tempfile.new("image_data.jpg")
    @tmp_img.write(@full)
    @picture.full_article_picture = @tmp_img
    @picture.full_article_picture.reprocess!
    logger.info(@picture.inspect)
    #@tmp_img = Tempfile.new("image_data.jpg")
    #@tmp_img.write(@half)
    #@picture.half_article_picture = @tmp_img
    #@picture.half_article_picture.reprocess!
    #@tmp_img = Tempfile.new("image_data.jpg")
    #@tmp_img.write(@spp_one_third)
    #@picture.spp_one_third_article_picture = @tmp_img
    #@picture.spp_one_third_article_picture.reprocess!
    #@tmp_img = Tempfile.new("image_data.jpg")
    #@tmp_img.write(@spp_full)
    #@picture.spp_full_article_picture = @tmp_img
    #@picture.spp_full_article_picture.reprocess!

    @picture.save!

    #@tmp_img.close

    respond_to do |format|
      format.html {redirect_to photos_path(params[:tab])} 
    end

  end



  private
  def resize_and_crop(image, w0, h0, w1, h1)

    rw = w1.to_f / w0
    rh = h1.to_f / h0

    unless rw > 1 or rh > 1
      w,h = w1, h1
      sx, sy = 0, 0

      if rw > rh
        h = (h0 * rw).to_i
        sy = (h - h1) / 2
      else
        w = (w0 * rh).to_i
        sx = (w - w1) / 2
      end

      image.thumbnail("#{w}x#{h}")
      image.crop("#{w1}x#{h1}+#{sx}+#{sy}")
    end

    image
  end

  def resize(x1,y1,x2, y2, path, type)
    img_orig = MiniMagick::Image.open(path)
    #img_orig.format ="jpg"
    resize_and_crop(img_orig, x1.to_i,y1.to_i,(x2.to_i-x1.to_i),(y2.to_i-y1.to_i))
    if type == 1
      img_orig.resize("540x250")
    elsif type == 2
      img_orig.resize("260x340")
    elsif type == 3
      img_orig.resize("210x310")
    elsif type == 4
      img_orig.resize("700x320")
    else
      img_orig.resize("460x346")
    end
    img_orig.to_blob
  end

end
