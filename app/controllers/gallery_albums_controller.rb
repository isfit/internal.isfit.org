class GalleryAlbumsController < ApplicationController
  
  def index
    @albums = GalleryAlbum.order('created_at DESC')
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @album }
    end
  end

  def show
    @album = GalleryAlbum.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @album }
    end
    
  end

  def new
      @album = GalleryAlbum.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @album }
      end
  end

  def edit
    @album = GalleryAlbum.find(params[:id])
  end
  
  def create
    @album = GalleryAlbum.new(params[:gallery_album])
    @album.user = current_user

    respond_to do |format|
      if @album.save
        format.html { redirect_to edit_gallery_album_path(@album.id), notice: 'Album was successfully created.' }
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @album = GalleryAlbum.find(params[:id])

    respond_to do |format|
      if @album.update_attributes(params[:gallery_album])
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @album = GalleryAlbum.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to gallery_albums_url }
      format.json { head :ok }
    end
  end
  
  # Photo methods, JSON only.
  
  def add_photo
    @photo = GalleryPhoto.new
    @photo.photo = params[:files][0]
    @photo.save
    render json: { photo: @photo }
  end
  
  def destroy_photo
    @photo = GalleryPhoto.find(params[:id])
    if (@photo.destroy)
      render json: true
    else
      render json: false
    end
  end
  
  def update_photo
    @photo =  GalleryPhoto.find(params[:id])
    if @photo.update_attributes(params[:photo])
      head :ok
    else  
      render json: @photo.errors, status: :unprocessable_entity
    end
  end

end
