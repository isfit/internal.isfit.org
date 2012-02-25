class OrganizationChartController < ApplicationController
  def index
    year = params[:year].nil? ? "2013":"#{params[:year]}"
    @festival = Festival.where(year: year).first
    @groups = @festival.groups
    @sections = @festival.sections
  end
end
