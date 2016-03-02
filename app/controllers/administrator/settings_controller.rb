module Administrator
  class SettingsController < BaseController
    def index
      @terms = Section.select("DISTINCT term").map { |s| [s.term, s.term] }
    end

    def set_current_term
      Setting.current_term = params[:current_term]
      redirect_to administrator_settings_path
    end

    def synchronize
      UniversitySyncJob.perform_later
      redirect_to administrator_settings_path
    end

    def section_preferences
      @students = User.students
      @sections = Section.includes(:section_preferences).with_current_term

      respond_to do |format|
        format.xlsx
      end
    end

    def student_preferences
      @students = User.students
      @sections = Section.includes(:section_preferences).with_current_term

      respond_to do |format|
        format.xlsx
      end
    end
  end
end
