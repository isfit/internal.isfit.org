class OrganizationChartController < ApplicationController
  def index
    year = "2013"
    unless params[:year].to_i%2 == 0
	year = params[:year]
    end
    puts year
    @festival = Festival.where(year: year).first
    @groups = @festival.groups
    @sections = @festival.sections
    @users = []
    if params[:group]
      group = Group.find(params[:group])
      @users  = group.users
    elsif params[:section]
      section = Section.find(params[:section])
      @users = section.users
    else
      @users  = @festival.users
    end
    respond_to do |format|
      format.vcf { render @users.uniq{|x| x.id}}
      format.html
    end
  end
end
