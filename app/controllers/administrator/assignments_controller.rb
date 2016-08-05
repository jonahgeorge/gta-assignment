require 'integer_linear_program'

module Administrator
  class AssignmentsController < BaseController
    before_action :set_students, only: [:new, :create, :edit, :update, :show]
    before_action :set_sections, only: [:new, :create, :edit, :update, :show]

    def index
      @assignments = Assignment.order(created_at: :desc)
    end

    def new
      @assignment = Assignment.new
      @assignments_fte = {}
      @assignments_is_fixed = {}
    end

    def edit
      @assignment = Assignment.find(params[:id])
      @assignments_fte = @assignment.assignments_fte
      @assignments_is_fixed = @assignment.assignments_is_fixed
    end

    def create
      @assignments_fte = params[:assignments_fte] || {}
      @assignments_is_fixed = params[:assignments_is_fixed] || {}

      if params[:commit] == "Run solver"
        begin
          problem = ::IntegerLinearProgram.new(@students, @sections, @assignments_fte, @assignments_is_fixed)
          problem.solve
          @assignments_fte = problem.results
        rescue RuntimeError
          flash[:alert] = "Infeasible solution"
        end
      end

      @assignment = Assignment.create(
        assignments_fte: @assignments_fte, assignments_is_fixed: @assignments_is_fixed)
      redirect_to administrator_assignment_path(@assignment)
    end

    def update
      @assignments_fte = params[:assignments_fte] || {}
      @assignments_is_fixed = params[:assignments_is_fixed] || {}

      if params[:commit] == "Run solver"
        begin
          problem = ::IntegerLinearProgram.new(@students, @sections, @assignments_fte, @assignments_is_fixed)
          problem.solve
          @assignments_fte = problem.results
        rescue RuntimeError
          flash[:alert] = "Infeasible solution"
        end
      end

      @assignment = Assignment.create(
        assignments_fte: @assignments_fte, assignments_is_fixed: @assignments_is_fixed)
      redirect_to administrator_assignment_path(@assignment)
    end

    def show
      @assignment = Assignment.find(params[:id])
      @assignments_fte = @assignment.assignments_fte
      @assignments_is_fixed = @assignment.assignments_is_fixed

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
        .where('current_enrollment >= ?', 25)
    end
  end
end
