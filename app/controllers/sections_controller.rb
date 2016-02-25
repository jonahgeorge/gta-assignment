class SectionsController < ApplicationController

  def index
    @sections = current_user.sections
  end

  def show
    @section = Section.find(params[:id])
  end

end
