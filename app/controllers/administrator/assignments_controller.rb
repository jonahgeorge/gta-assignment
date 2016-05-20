require 'integer_linear_program'

module Administrator
  class AssignmentsController < BaseController
    before_action :set_students, only: [:new, :create, :edit, :update, :show]
    before_action :set_sections, only: [:new, :create, :edit, :update, :show]

    def index
      @assignments = Assignment.all.order(created_at: :desc)
    end

    def new
      @assignment = Assignment.new
      @pairs = {}
    end

    def edit
      @assignment = Assignment.find(params[:id])
      @pairs = @assignment.assignments
    end

    def create
      if params[:commit] == "Save"
        @pairs = params[:assignments] || {}
      elsif params[:commit] == "Run solver"
        problem = ::IntegerLinearProgram.new(@students, @sections, params[:assignments])
        problem.solve
        @pairs = problem.results
      end

      @assignment = Assignment.create(assignments: @pairs)
      redirect_to administrator_assignment_path(@assignment)
    end

    def update
      if params[:commit] == "Save"
        @pairs = params[:assignments] || {}
      elsif params[:commit] == "Run solver"
        problem = ::IntegerLinearProgram.new(@students, @sections, params[:assignments])
        problem.solve
        @pairs = problem.results
      end

      @assignment = Assignment.create(assignments: @pairs)
      redirect_to administrator_assignment_path(@assignment)
    end

    def show
      @assignment = Assignment.find(params[:id])
      @pairs = @assignment.assignments

      respond_to do |format|
        format.html
        format.txt  { render 'show.txt.erb' }
        format.xlsx { render xlsx: 'show.xlsx.axlsx' }
      end
    end

    private

    def set_students
      @students = User.includes([{section_preferences: :section}, :experiences]).gtas
    end

    def set_sections
      @sections = Section.includes(
        {course: [:requirements, :department]},
        {instructor: :student_preferences}, :section_preferences)
        .with_current_term
    end
  end
end
