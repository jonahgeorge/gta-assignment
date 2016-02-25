module Administrator
  class AssignmentController < BaseController

    def index
      @students = User.students
      @instructos = User.instructors
      @sections = Section.all
    end

  end
end
