module Instructor
  class SectionsController < BaseController

    def index
      # FIXME
      @sections = Section.where(instructor: "Zhang, J.")
    end

    def show
      @section = Section.find(params[:id])
    end

  end
end
