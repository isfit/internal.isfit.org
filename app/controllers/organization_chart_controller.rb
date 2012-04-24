class OrganizationChartController < ApplicationController
  def index
    year = params[:year].nil? ? "2013":"#{params[:year]}"
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
      format.vcard { render @users}
      format.html
    end
  end
end
