class ContactLogPeopleController < ApplicationController
  # GET /contact_log_people
  # GET /contact_log_people.json
#  def index
#    @contact_log_people = ContactLogPerson.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.json { render json: @contact_log_people }
#    end
#  end

  # GET /contact_log_people/1
  # GET /contact_log_people/1.json
  def show
    @contact_log_person = ContactLogPerson.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contact_log_person }
    end
  end

  # GET /contact_log_people/new
  # GET /contact_log_people/new.json
  def new
    @contact_log_person = ContactLogPerson.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact_log_person }
    end
  end

  # GET /contact_log_people/1/edit
  def edit
    @contact_log_person = ContactLogPerson.find(params[:id])
  end

  # POST /contact_log_people
  # POST /contact_log_people.json
  def create
    @contact_log_person = ContactLogPerson.new(params[:contact_log_person])

    respond_to do |format|
      if @contact_log_person.save
        format.html { redirect_to @contact_log_person, notice: 'Contact log unit was successfully created.' }
        format.json { render json: @contact_log_person, status: :created, location: @contact_log }
      else
        format.html { render action: "new" }
        format.json { render json: @contact_log_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contact_log_people/1
  # PUT /contact_log_people/1.json
  def update
    @contact_log_person = ContactLogPerson.find(params[:id])

    respond_to do |format|
      if @contact_log_person.update_attributes(params[:contact_log_person])
        format.html { redirect_to @contact_log_person, notice: 'Contact log unit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contact_log_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contact_log_people/1
  # DELETE /contact_log_people/1.json
  def destroy
    @contact_log_person_unit = ContactLogPerson.find(params[:id])
    @contact_log_person_unit.destroy

    respond_to do |format|
      format.html { redirect_to contact_log_people_url }
      format.json { head :no_content }
    end
  end
end
