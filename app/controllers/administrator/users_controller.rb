module Administrator
  class UsersController < BaseController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    # GET /admin/users
    def index
      @users = User.all
    end

    # GET /admin/users/1
    def show
    end

    # GET /admin/users/new
    def new
      @user = User.new
    end

    # GET /admin/users/1/edit
    def edit
    end

    # POST /admin/users
    def create
      @user = User.new(user_params)

      if @user.save
        redirect_to administrator_user_path(@user), notice: 'User was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /admin/users/1
    def update
      if @user.update(user_params)
        redirect_to administrator_user_path(@user), notice: 'User was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /admin/users/1
    def destroy
      @user.destroy
      redirect_to administrator_users_url, notice: 'User was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def user_params
        params[:user].permit(:is_administrator, :fte)
      end
  end
end
