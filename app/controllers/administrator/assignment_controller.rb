module Administrator
  class AssignmentController < BaseController

    def index
      @students = User.students
      @instructos = User.instructors
      @sections = Section.includes(course: :department).with_current_term
    end

  end
end
