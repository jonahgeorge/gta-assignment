module Students
  class SkillsController < BaseController
    before_action :set_skill, only: [:show, :destroy]

    def index
      @skills = current_user.skills
    end

    def new
      @skill = current_user.skills.new
    end

    def create
      @skill = current_user.skills.new(skill_params)

      if @skill.save
        redirect_to students_skills_path, notice: 'Skill was successfully created.'
      else
        render :new
      end
    end

    def destroy
      @skill.delete
      redirect_to students_skills_path, notice: 'Skill was successfully destroyed.'
    end

    private

      def set_skill
        @skill = Skill.find(params[:id])
      end

      def skill_params
        params[:students_skill].permit(:skill_id, :value)
      end
  end
end
