class SectionPreferencesController < ApplicationController
  before_action :set_section_preference, only: [:destroy]
  before_action :set_sections, only: [:new, :create]

  def index
    @section_preferences = current_user.section_preferences.with_current_term
  end

  def new
    @section_preference = current_user.section_preferences.new
  end

  def create
    @section_preference = current_user.section_preferences.new(section_preference_params)

    if @section_preference.save
      redirect_to section_preferences_path, notice: 'Section preference was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @section_preference.destroy
    redirect_to section_preferences_path, notice: 'Section preference was successfully destroyed.'
  end

  private

  def set_section_preference
    @section_preference = SectionPreference.find(params[:id])
  end

  def set_sections
    @sections = Section.includes(course: :department).with_current_term
  end

  def section_preference_params
    params[:section_preference].permit(:section_id, :value)
  end
end
