require 'integer_linear_program'

module Administrator
  class AssignmentsController < BaseController

    def index
      @assignments = Assignment.all
    end

    def show
      @assignment = Assignment.find(params[:id])
      @pairs = @assignment.assignments

      @students = User.includes([{section_preferences: :section}, :experiences]).students
      @sections = Section.includes([{course: [:requirements, :department]}, {instructor: :student_preferences}, :section_preferences]).with_current_term
    end

    def create
      @students = User.includes([{section_preferences: :section}, :experiences]).students
      @sections = Section.includes([{course: [:requirements, :department]}, {instructor: :student_preferences}, :section_preferences]).with_current_term
      @pairs = params[:assignments]

      if params[:commit] == "Export to text"
        render xlsx: 'index.xlsx.axlsx'
      elsif params[:commit] == "Export to pdf"
        render xlsx: 'index.xlsx.axlsx'
      else
        problem = ::IntegerLinearProgram.new(@students, @sections, params[:assignments])
        problem.solve
        @pairs = problem.results
        @assignment = Assignment.create! assignments: @pairs
        redirect_to administrator_assignments_path(@assignment)
      end
    end
  end
end
