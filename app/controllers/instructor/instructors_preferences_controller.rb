module Instructor
  class PreferencesController < BaseController
    before_filter :set_section
    before_filter :set_students, :except => [:destory]

    def new
      @preference = current_user.instructor_preferences.new
    end

    def create
      @preference = current_user.instructor_preferences.new(instructor_preference_params)
      @preference.section_id = @section.id

      if @preference.save
        redirect_to instructors_section_path(@section)
      else
        render "new"
      end
    end

    def destroy
      @preference = Preference.find(params[:id])
      @preference.destroy
      redirect_to instructors_section_path(@section), notice: 'Preference was successfully destroyed.'
    end

    private

      def instructors_preference_params
        params[:instructor_preference].permit(:student_id, :value)
      end

      def set_section
        @section = Section.find(params[:section_id])
      end

      def set_students
        @students = Student.all
      end
  end
end
