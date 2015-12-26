class PreferencesController < ApplicationController
  before_action :set_preference, only: [:edit, :update, :destroy]
  before_action :set_departments, only: [:new, :create, :edit, :update]

  def index
    @preferences = current_user.preferences
  end

  def new
    @preference = current_user.preferences.new
  end

  def create
    @preference = current_user.preferences.new(preference_params)

    if @preference.save
      redirect_to settings_preferences_path, notice: 'Preference was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @preference.update(preference_params)
      redirect_to settings_preferences_path, notice: 'Preference was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @preference.destroy
    respond_to do |format|
      format.html { redirect_to settings_preferences_path, notice: 'Preference was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
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
