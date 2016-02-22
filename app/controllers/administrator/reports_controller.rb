module Administrator
  class ReportsController < BaseController

    def student_preferences
      @students = Student.all
      @department = Department.find_by_subject_code("CS")

      respond_to do |format|
        format.xlsx
      end
    end

    def instructor_preferences
      @instructors = Instructor.all

      respond_to do |format|
        format.xlsx
      end
    end

  end
end
