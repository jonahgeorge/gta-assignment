module Administrator
  class SettingsController < BaseController
    def index
    end

    def synchronize
      UniversitySyncJob.perform_later
      redirect_to administrator_settings_path
    end

    def section_preferences
      @students = User.students
      @sections = Section.includes(:section_preferences)

      respond_to do |format|
        format.xlsx
      end
    end

    def student_preferences
      @students = User.students
      @sections = Section.includes(:section_preferences)
      
      respond_to do |format|
        format.xlsx
      end
    end
  end
end
