require 'integer_linear_program'

module Administrator
  class AssignmentController < BaseController

    def index
      @students = User.includes([{section_preferences: :section}, :experiences]).students
      @sections = Section.includes([{course: [:requirements, :department]}, {instructor: :student_preferences}, :section_preferences]).with_current_term
      @assignments = params[:assignments]

      if params[:commit] == "Export to pdf"
        render xlsx: 'index.xlsx.axlsx'
      else
        problem = ::IntegerLinearProgram.new(@students, @sections, params[:assignments])
        problem.solve
        @assignments = problem.results
      end
    end

  end
end
