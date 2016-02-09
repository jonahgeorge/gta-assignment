module Administrators
  class SectionsController < BaseController
    def index
      @sections = Section.includes(course: :department).all
    end
  end
end
