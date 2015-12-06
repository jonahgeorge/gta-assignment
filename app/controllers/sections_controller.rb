class SectionsController < ApplicationController
  def index
    @sections = Section.all
  end

  def synchronize
    redirect_to sections_path
  end
end
