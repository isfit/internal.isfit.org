class ApplicantsController < ApplicationController
  load_and_authorize_resource


  def statistics
    @positions = Position.where(:admission_id =>5, :number => 1..100)
    @applicants = Applicant.all
    @simple_stat = Hash.new
    @positions.each do |p|
      @simple_stat[p] = Float((@applicants.find_all {|a| a.position_id_1 == p.id}).size)/Float(p.number)
    end
    @stat = Hash.new
    @positions.each do |p|
      @stat[p.title_en] = 5*Float((@applicants.find_all {|a| a.position_id_1 == p.id}).size)/Float(p.number) + 3*Float((@applicants.find_all {|a| a.position_id_2 == p.id}).size)/Float(p.number)+ Float((@applicants.find_all {|a| a.position_id_3 == p.id}).size)/Float(p.number)
    end
    @all_pos = Position.where(:admission_id => 5)
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
  end

  def update
    @applicant = Applicant.find(params[:id])
    if @applicant.update_attributes(params[:applicant])
      redirect_to applicants_path
    else
      render :edit
    end

  end

  def index
    if current_user.role?(:admin) || current_user.role?(:recruitment) || current_user.has_role?(:board)
      @applicants = Applicant.all
    elsif current_user.role?(:wingman)
      @applicants = Applicant.applicants_in_same_section( current_user)
    elsif current_user.role?(:interviewer) || current_user.role?(:leader)
      @applicants = Applicant.applicants_in_same_group( current_user )
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
