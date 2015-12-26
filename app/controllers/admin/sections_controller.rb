module Admin
  class SectionsController < ApplicationController
    def index
      @sections = Section.includes(course: :department).all
    end
  end
end
