module Administrator
  class ReportsController < BaseController

    def student_preferences
      @users = User.where(role: 0)

      respond_to do |format|
        format.pdf { render pdf: "student_preferences" }
      end
    end

    def instructor_preferences
      @users = User.where(role: 1)

      respond_to do |format|
        format.pdf { render pdf: "instructor_preferences" }
      end
    end

  end
end
