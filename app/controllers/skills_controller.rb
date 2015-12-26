class SkillsController < ApplicationController
  before_action :set_skill, only: [:show, :edit, :update, :destroy]

  def index
    @skills = current_user.skills
  end

  def new
    @skill = Skill.new
  end

  def edit
  end

  def create
    current_user.skills << Skill.find(params[:skill_ids])
    redirect_to skills_path, notice: 'Skill was successfully created.'
  end

  def update
    current_user.skills << Skill.find(params[:skill_ids])
    redirect_to skills_path, notice: 'Skill was successfully created.'
  end

  def destroy
    current_user.skills.delete(@skill)
    redirect_to skills_path, notice: 'Skill was successfully destroyed.'
  end

  private
    def set_skill
      @skill = Skill.find(params[:id])
    end

    def skill_params
      params[:skill].permit(:skill_id)
    end
end
