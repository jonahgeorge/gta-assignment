class ExperiencesController < ApplicationController
  before_action :set_experience, only: [:show, :destroy]

  def index
    @experiences = current_user.experiences
  end

  def new
    @experience = current_user.experiences.new
  end

  def create
    @experience = current_user.experiences.new(experience_params)

    if @experience.save
      redirect_to experiences_path, notice: 'Experience was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @experience.delete
    redirect_to experiences_path, notice: 'Experience was successfully destroyed.'
  end

  private

  def set_experience
    @experience = Experience.find(params[:id])
  end

  def experience_params
    params[:experience].permit(:skill_id, :value)
  end
end
