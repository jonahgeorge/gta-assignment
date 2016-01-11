module Student
  class BaseController < ::ApplicationController
    before_filter :authenticate
    before_filter :authorize

    def authenticate
      unless signed_in?
        return redirect_to root_path, alert: "Must be logged in."
      end
    end

    def authorize
      unless current_user.role == "student"
        return redirect_to root_path, alert: "Must be a student."
      end
    end
  end
end
