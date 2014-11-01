#encoding:utf-8
class ApplicantsController < ApplicationController
  load_and_authorize_resource
  before_filter :set_positions_interviewers_and_status, only: [:edit, :new, :update, :create]


  def statistics
    @positions = Position.published
    @applicants = visible_applicants
    @simple_stat = Hash.new
    @positions.each do |p|
      @simple_stat[p] = Float((@applicants.find_all {|a| a.position_id_1 == p.id}).size)/Float(p.number)
    end
    @stat = Hash.new
    @positions.each do |p|
      @stat[p.title_en] = 5*Float((@applicants.find_all {|a| a.position_id_1 == p.id}).size)/Float(p.number) + 3*Float((@applicants.find_all {|a| a.position_id_2 == p.id}).size)/Float(p.number)+ Float((@applicants.find_all {|a| a.position_id_3 == p.id}).size)/Float(p.number)
    end
    @all_pos = @positions
    @no_apply = []

    @all_pos.each do |p|
      tot  = (@applicants.find_all {|a| a.position_id_1 == p.id}).size + (@applicants.find_all {|a| a.position_id_2 == p.id}).size + (@applicants.find_all {|a| a.position_id_3 == p.id}).size
      if tot == 0
        @no_apply << p
      end
    end

    @simple_stat = @simple_stat.sort {|a,b| b[1] <=> a[1]}
    @stat = @stat.sort {|a,b| b[1] <=> a[1]}

  end


  def interviews
    @applicants = Applicant.find_by_sql("select *, interview_place_1 as place, interview_time_1 as time from applicants where interviewer_id_1_1 = #{current_user.id} UNION select *, interview_place_1 as place, interview_time_1 as time from applicants where interviewer_id_1_2 = #{current_user.id}")
    @applicants_1 = Applicant.where("interviewer_id_1_1 = #{current_user.id} OR interviewer_id_1_2 = #{current_user.id}")
    @applicants_2 = Applicant.where("interviewer_id_2_1 = #{current_user.id} OR interviewer_id_2_2 = #{current_user.id}")
    @applicants_3 = Applicant.where("interviewer_id_3_1 = #{current_user.id} OR interviewer_id_3_2 = #{current_user.id}")

  end

  def show
    @applicant = Applicant.find(params[:id])

    unless visible_applicants.any? {|a| a.id.eql?(@applicant.id)}
      redirect_to(applicants_path, alert: "Du har ikke tilgang til denne søkeren") and return
    end

    @status = {  0 => 'Not contacted',
      1 => 'Meeting planned',
      2 => 'Meeting done',
      3 => 'Of interest',
      4 => 'Recruited',
      5 => 'Not of interest' }
  end

  def edit
    @applicant = Applicant.find(params[:id])
    unless visible_applicants.any? {|a| a.id.eql?(@applicant.id)}
      redirect_to(applicants_path, alert: "Du har ikke tilgang til denne søkeren") and return
    end

    if @applicant.deleted == false || current_user.role?(:admin)
      render :edit
    else
      redirect_to applicants_path, notice: "This applicant has been deleted."
    end

  end

  def new
    @applicant = Applicant.new
  end

  def create
    @applicant = Applicant.new(params[:applicant])
    if @applicant.save
      redirect_to applicants_path, notice: "Applicant was successfully created."
    else
      render "new"
    end
  end

  def notifier
    @count = Applicant.count
  end

  def last
    last_count = params[:last_count].to_i
    @count = Applicant.count

    if @count > last_count
      @applicant = Applicant.last

      unless visible_applicants.any? {|a| a.id.eql?(@applicant.id)}
        @applicant.firstname = "Hemmelig"
        @applicant.lastname = "søker"
      end
    end

    respond_to do |format|
      format.json do
        render json: { applicant: @applicant,
                       count:     @count }
      end
    end
  end

  def update
    @applicant = Applicant.find(params[:id])
    if @applicant.update_attributes(params[:applicant])
      redirect_to applicants_path, notice: "Applicant was successfully updated"
    else
      render :edit
      #redirect_to edit_applicant_path(@applicant), notice: @applicant.errors.full_messages.to_s
    end

  end

  def index
    @applicants = visible_applicants

    @status = {  0 => 'Not contacted',
      1 => 'Meeting planned',
      2 => 'Meeting done',
      3 => 'Of interest',
      4 => 'Recruited',
      5 => 'Not of interest' }
  end

  private
  def visible_applicants
    if current_user.role?(:admin) || current_user.role?(:recruiting) || current_user.role?(:board)
      return Applicant.where(deleted: false, has_account: false).all
    elsif current_user.role?(:wingman) || current_user.role?(:leader)
      return Applicant.applicants_in_same_section(current_user)
    elsif current_user.role?(:interviewer)
      return Applicant.applicants_in_same_group( current_user)
    else
      CanCan::AccessDenied
    end
  end

  def set_positions_interviewers_and_status
    @positions = Position.published
    @interviewers = User.in_festival
    @status = { 0 => 'Not contacted',
      1 => 'Meeting planned',
      2 => 'Meeting done',
      3 => 'Of interest',
      4 => 'Recruited',
      5 => 'Not of interest' }
  end
end
