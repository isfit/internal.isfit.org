class WikiCategoriesController < ApplicationController
  # GET /wiki_categories
  # GET /wiki_categories.json
  def index
    @wiki_categories = WikiCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @wiki_categories }
    end
  end

  # GET /wiki_categories/1
  # GET /wiki_categories/1.json
  def show
    @wiki_category = WikiCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wiki_category }
    end
  end

  # GET /wiki_categories/new
  # GET /wiki_categories/new.json
  def new
    @wiki_category = WikiCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @wiki_category }
    end
  end

  # GET /wiki_categories/1/edit
  def edit
    @wiki_category = WikiCategory.find(params[:id])
  end

  # POST /wiki_categories
  # POST /wiki_categories.json
  def create
    @wiki_category = WikiCategory.new(params[:wiki_category])
    @wiki_category.deleted = false

    respond_to do |format|
      if @wiki_category.save
        format.html { redirect_to @wiki_category, notice: 'Wiki category was successfully created.' }
        format.json { render json: @wiki_category, status: :created, location: @wiki_category }
      else
        format.html { render action: "new" }
        format.json { render json: @wiki_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /wiki_categories/1
  # PUT /wiki_categories/1.json
  def update
    @wiki_category = WikiCategory.find(params[:id])

    respond_to do |format|
      if @wiki_category.update_attributes(params[:wiki_category])
        format.html { redirect_to @wiki_category, notice: 'Wiki category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @wiki_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wiki_categories/1
  # DELETE /wiki_categories/1.json
  def destroy
    @wiki_category = WikiCategory.find(params[:id])
    @wiki_category.deleted = true
    @wiki_category.save

    respond_to do |format|
      format.html { redirect_to wiki_categories_url }
      format.json { head :no_content }
    end
  end
end
