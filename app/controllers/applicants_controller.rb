class ApplicantsController < ApplicationController
load_and_authorize_resource

#	helper :sort
#	include SortHelper
#  Paperclip::Railtie.insert

#  layout 'application_no_boxes'
  helper_method :sort_column, :sort_direction

  
  def statistics
    @positions = Position.where(:admission_id =>3, :number => 1..100)
    #find(:all, :conditions => {:admission_id => 3, :number => 1..100 , :deleted => 0})
    @applicants = Applicant.all
    @simple_stat = Hash.new
    @positions.each do |p|
      @simple_stat[p] = Float((@applicants.find_all {|a| a.position_id_1 == p.id}).size)/Float(p.number)
    end
    @stat = Hash.new
    @positions.each do |p|
      @stat[p.title_en] = 5*Float((@applicants.find_all {|a| a.position_id_1 == p.id}).size)/Float(p.number) + 3*Float((@applicants.find_all {|a| a.position_id_2 == p.id}).size)/Float(p.number)+ Float((@applicants.find_all {|a| a.position_id_3 == p.id}).size)/Float(p.number)
    end
    @all_pos = Position.where(:admission_id => 3)
    #.find(:all, :conditions => {:admission_id => 1, :deleted => 0})
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
		@applicants = Applicant.find_by_sql("
			select *, interview_place_1 as place, interview_time_1 as time 
				from applicants where
				interviewer_id_1_1 = #{current_user.id} UNION
			select *, interview_place_1 as place, interview_time_1 as time 
				from applicants where
				interviewer_id_1_2 = #{current_user.id}")
	end

	def show
		@recruiting = can_access?('applicants', 'browse_all')
		@applicant = Applicant.find(params[:id])
    
		@status = {	0 => 'Not contacted',
					1 => 'Meeting planned',
					2 => 'Meeting done',
					3 => 'Of interest',
					4 => 'Recruited',
					5 => 'Not of interest' }
	end

	def edit
		@recruiting = can_access?('applicants','browse_all')
		@applicant = Applicant.find(params[:id])
                @positions = [Position.new]
                @positions.concat(Position.find_all_active_positions_alfa)
		@sections = Group.find(:all, :order => "name_no asc")

		@status = {	0 => 'Not contacted',
					1 => 'Meeting planned',
					2 => 'Meeting done',
					3 => 'Of interest',
					4 => 'Recruited',
					5 => 'Not of interest' }

		@functionaries = 
			LdapUnit.get_by_dn("ou=isfit11,ou=units,dc=isfit,dc=org").functionaries(true)
		nobody = LdapUser.new({})
		nobody.lastname = "<Not set"
		nobody.firstname = "yet>"
		nobody.id = -1
		@functionaries.insert(0, nobody)

		if request.post?
			
			@applicant.attributes = params[:applicant]
	

			if @applicant.save
				redirect_to :action => 'index'
			end
		end
	end

  def index
    #@current_user = current_user
    #sort_init 'applicants.id'
    #sort_update



    #leader_joins = "
    #                    left outer join positions p1 
    #                            on p1.id = applicants.position_id_1
    #                    left outer join groups on groups.id = p1.group_id
    #                    left outer join positions p2
    #                            on p2.id = applicants.position_id_2
    #                    left outer join positions p3
    #                            on p3.id = applicants.position_id_3"

    #                            leader_conditions = "
    #                    p1.group_dn = \"#{current_user.unit.dn}\" or
    #                    p2.group_dn = \"#{current_user.unit.dn}\" or
    #                    p3.group_dn = \"#{current_user.unit.dn}\""

    #                    recruiting_joins = "
    #                    left outer join positions p1 
    #                            on p1.id = applicants.position_id_1
    #                    left outer join groups on groups.id = p1.group_id"

    #                    assistant_conditions = "
    #                    (p1.group_dn like \"%#{current_user.unit.parent.dn}\" or
    #                    p2.group_dn like \"%#{current_user.unit.parent.dn}\" or
    #                    p3.group_dn like \"%#{current_user.unit.parent.dn}\")"

    #                    board_conditions = "
    #                    (p1.admission_nr = 2 or p1.admission_nr = 3 or p1.admission_nr = 4) and applicants.deleted =0"

    #                    president_conditions ="
    #                    (p1.admission_nr = 1 or p1.admission_nr = 2 or p1.admission_nr=3) and applicants.deleted = 0"

    #                    @recruiting = can_access?('applicants', 'browse_all')

    #                    @assistant = current_user.unit.name == 'board'


    #                    @applicants = Applicant.paginate(:page => params[:page],:order => sort_clause,
    #                                                     :include => [:first_position,
    #                                                       :second_position, :third_position],
    #                                                       :joins => @recruiting ?
    #                                                       recruiting_joins : leader_joins,:order => sort_column + " " + sort_direction,
    #                                                       :conditions => @recruiting ? "" : (@assistant ? 
    #                                                                                          assistant_conditions : leader_conditions)
    #                                                    )

                                                        #	@applicants = Applicant.paginate(:page => params[:page],
                                                        #		:order => sort_clause,
                                                        #		:include => [:first_position, 
                                                        #		:second_position, :third_position],
                                                        #		:joins => leader_joins,
                                                        #		:conditions => (@recruiting ? president_conditions : board_conditions)
                                                        #		)
    @applicants = Applicant.all
    @status = {	0 => 'Not contacted',
      1 => 'Meeting planned',
      2 => 'Meeting done',
      3 => 'Of interest',
      4 => 'Recruited',
      5 => 'Not of interest' }
  end

  private

  def sort_column
    Applicant.column_names.include?(params[:sort]) ? params[:sort] : "applicants.id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end      

end
