require "csv"

module Administrator
  class ReportsController < BaseController

    def student_preferences
      @students = User.where(role: "student")
      @department = Department.find_by_subject_code("CS")

      respond_to do |format|
        format.xlsx
      end
    end

    def instructor_preferences
      @users = User.where(role: "instructor")

      respond_to do |format|
        format.xlsx
      end
    end

  end
end
