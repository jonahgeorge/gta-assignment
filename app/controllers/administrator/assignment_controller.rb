require 'integer_linear_program'

module Administrator
  class AssignmentController < BaseController

    def index
      @students = User.students
      @sections = Section.includes(course: :department).with_current_term
      @assignments = {}
    end

    def run
      raw_assignments = params[:assignments]
      @assignments = raw_assignments

      @students = User.includes([{section_preferences: :section}, :experiences]).students
      @sections = Section.includes([{course: :requirements}, {instructor: :student_preferences}, :section_preferences]).with_current_term

      problem = ::IntegerLinearProgram.new(@students, @sections)
      problem.solve
      @assignments = problem.hash_array_results

      render "administrator/assignment/index"
    end

  end
end
