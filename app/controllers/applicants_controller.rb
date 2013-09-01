class ApplicantsController < ApplicationController
  load_and_authorize_resource


  def statistics
    @positions = Position.published
    @applicants = Applicant.where(deleted: false)
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
    #@recruiting = can_access?('applicants', 'browse_all')
    @applicant = Applicant.find(params[:id])

    @status = {	0 => 'Not contacted',
      1 => 'Meeting planned',
      2 => 'Meeting done',
      3 => 'Of interest',
      4 => 'Recruited',
      5 => 'Not of interest' }
  end

  def edit
    @applicant = Applicant.find(params[:id])
    @positions = Position.published
    @interviewers = User.in_festival

    @status = {	0 => 'Not contacted',
      1 => 'Meeting planned',
      2 => 'Meeting done',
      3 => 'Of interest',
      4 => 'Recruited',
      5 => 'Not of interest' }
    if @applicant.deleted == false || current_user.role?(:admin)
      render :edit
    else
      redirect_to applicants_path, notice: "This applicant has been deleted."
    end

  end

  def new
    @applicant = Applicant.new
    @positions = Position.published
    @interviewers = User.in_festival

    @status = {	0 => 'Not contacted',
      1 => 'Meeting planned',
      2 => 'Meeting done',
      3 => 'Of interest',
      4 => 'Recruited',
      5 => 'Not of interest' }
  end

  def create
    @applicant = Applicant.new(params[:applicant])
    if @applicant.save
      redirect_to applicants_path, notice: "Applicant was successfully created."
    else
    @positions = Position.published
    @interviewers = User.in_festival
    @status = {	0 => 'Not contacted',
      1 => 'Meeting planned',
      2 => 'Meeting done',
      3 => 'Of interest',
      4 => 'Recruited',
      5 => 'Not of interest' }
      render "new"
    end
  end

  def update
    @applicant = Applicant.find(params[:id])
    if @applicant.update_attributes(params[:applicant])
      redirect_to applicants_path, notice: "Applicant was successfully updated"
    else
      redirect_to edit_applicant_path(@applicant), message: "Something went wrong"
    end

  end

  def index
    #if current_user.role?(:admin) || current_user.role?(:recruiting) || current_user.role?(:board)
    #  @applicants = Applicant.where(deleted: false).all
    #elsif current_user.role?(:wingman)
    #  @applicants = Applicant.applicants_in_same_section(current_user)
    #elsif current_user.role?(:interviewer) || current_user.role?(:leader)
    #  @applicants = Applicant.applicants_in_same_group( current_user )
    if current_user.role?(:admin) || current_user.role?(:board)
      @applicants = Applicant.where(deleted: false).all
    else
      CanCan::AccessDenied
    end
    @status = {	0 => 'Not contacted',
      1 => 'Meeting planned',
      2 => 'Meeting done',
      3 => 'Of interest',
      4 => 'Recruited',
      5 => 'Not of interest' }
  end
end 
