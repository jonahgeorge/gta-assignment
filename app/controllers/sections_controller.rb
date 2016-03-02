class SectionsController < ApplicationController

  def index
    @sections = current_user.sections.with_current_term
  end

  def show
    @section = Section.find(params[:id])
  end

end
