class OrganizationChartController < ApplicationController

  def index
    @board = Festival.in_progress.groups.first
    @sections = Festival.in_progress.sections
  end

  def section
    @section = Section.find_by_id(params[:id])
    respond_to do |format|
      format.html { redirect_to "/organization_chart" }
      format.js
    end
  end

  def group
    @group = Group.find_by_id(params[:id])
    respond_to do |format|
      format.html { redirect_to "/organization_chart" }
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
