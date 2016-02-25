class SkillsController < ApplicationController
  before_action :set_skill, only: [:edit, :update, :destroy]

  def index
    @skills = Skill.all
  end

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new(skill_params)

    if @skill.save
      if params[:redirect]
        redirect_to params[:redirect], notice: 'Skill was successfully created.'
      else
        redirect_to skills_path, notice: 'Skill was successfully created.'
      end
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @skill.update(skill_params)
      redirect_to skills_path, notice: 'Skill was successfully updated.'
    else
      render "edit"
    end
  end

  def destroy
    @skill.destroy
    redirect_to skills_path, notice: 'Skill was successfully destroyed.'
  end

  private

  def skill_params
    params[:skill].permit(:name, :type)
  end

  def set_skill
    @skill = Skill.find(params[:id])
  end

end
