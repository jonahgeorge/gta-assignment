class StudentPreferencesController < ApplicationController
  before_filter :set_section
  before_filter :set_students, except: [:destroy]

  def new
    @preference = current_user.student_preferences.new
  end

  def create
    @preference = current_user.student_preferences.new(student_preference_params)
    @preference.section_id = @section.id

    if @preference.save
      redirect_to section_path(@section)
    else
      render "new"
    end
  end

  def destroy
    @preference = Preference.find(params[:id])
    @preference.destroy
    redirect_to section_path(@section), notice: 'Student preference was successfully destroyed.'
  end

  private

  def student_preference_params
    params[:student_preference].permit(:student_id, :value)
  end

  def set_section
    @section = Section.find(params[:section_id])
  end

  def set_students
    @students = User.students
  end
end
