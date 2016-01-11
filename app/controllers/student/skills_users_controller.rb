module Student
  class SkillsUsersController < BaseController
    before_action :set_skill, only: [:show, :destroy]

    def index
      @skills = current_user.skills_users
    end

    def new
      @skill = current_user.skills_users.new
    end

    def create
      @skill = current_user.skills_users.new(skill_params)

      if @skill.save
        redirect_to student_skills_users_path, notice: 'Skill was successfully created.'
      else
        render :new
      end
    end

    def destroy
      @skill.delete
      redirect_to student_skills_users_path, notice: 'Skill was successfully destroyed.'
    end

    private
      def set_skill
        @skill = SkillsUser.find(params[:id])
      end

      def skill_params
        puts params
        params[:skills_user].permit(:skill_id)
      end
  end
end
