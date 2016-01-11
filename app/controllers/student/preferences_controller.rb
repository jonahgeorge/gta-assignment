module Student
  class PreferencesController < BaseController
    before_action :set_preference, only: [:destroy]
    before_action :set_departments, only: [:new, :create]

    def index
      @preferences = current_user.preferences
    end

    def new
      @preference = current_user.preferences.new
    end

    def create
      @preference = current_user.preferences.new(preference_params)

      if @preference.save
        redirect_to student_preferences_path, notice: 'Preference was successfully created.'
      else
        render :new
      end
    end

    def destroy
      @preference.destroy
      redirect_to student_preferences_path, notice: 'Preference was successfully destroyed.'
    end

    private

      def set_preference
        @preference = Preference.find(params[:id])
      end

      def set_departments
        @departments = Department.all
      end

      def preference_params
        params[:preference].permit(:course_id, :value)
      end
  end
end
