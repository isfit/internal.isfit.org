class OrganizationChartController < ApplicationController

  def index
    festival = Festival.in_progress
    @board = festival.groups.first
    @sections = festival.sections
    @research = Group.find(159)
    respond_to do |format|
      format.vcf { render festival.users.uniq{|x| x.id} }
      format.html
    end
  end

  def section
    @section = Section.find_by_id(params[:id])
    respond_to do |format|
      format.html { redirect_to "/organization_chart" }
      format.vcf { render @section.users.uniq{|x| x.id}}
      format.js
    end
  end

  def group
    @group = Group.find_by_id(params[:id])
    respond_to do |format|
      format.html { redirect_to "/organization_chart" }
      format.vcf { render @group.users.uniq{|x| x.id}}
      format.js
    end
  end

  def board
    @board = Group.find_by_id(params[:id])
    respond_to do |format|
      format.html { redirect_to "/organization_chart" }
      format.js
    end
  end
end
