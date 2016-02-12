module Instructors
  class ProfileController < BaseController

    def edit
      @user = current_user
    end

    def update
      current_user.update(user_params)
      render "edit"
    end

  end
end
