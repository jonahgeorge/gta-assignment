module Student
  class UsersController < BaseController
    before_action :set_user, only: [:show, :edit, :update]

    def show
    end

    def edit
    end

    def update
      if @user.update(user_params)
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render :edit
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def user_params
        params[:user].permit(:name)
      end
  end
end
