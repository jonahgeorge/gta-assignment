module Instructors
  class InstructorsPreferencesController < BaseController
    before_filter :set_section
    before_filter :set_students, :except => [:destory]

    def new
      @preference = Instructors::Preference.new
    end

    def create
      @preference = Instructors::Preference.new(instructors_preference_params)
      @preference.section_id = @section.id
      @preference.instructor_id = current_user.id

      if @preference.save
        redirect_to instructors_section_path(@section)
      else
        render "new"
      end
    end

    def destroy
      @preference = Instructors::Preference.find(params[:id])
      @preference.destroy
      redirect_to instructors_section_path(@section), notice: 'Preference was successfully destroyed.'
    end

    private

      def instructors_preference_params
        params[:instructors_preference].permit(:student_id, :value)
      end

      def set_section
        @section = Section.find(params[:section_id])
      end

      def set_students
        @students = Student.all
      end
  end
end
