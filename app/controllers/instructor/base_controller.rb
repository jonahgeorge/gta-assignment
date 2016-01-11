module Instructor
  class BaseController < ::ApplicationController
    before_filter :authenticate
    before_filter :authorize

    def authenticate
      unless signed_in?
        return redirect_to root_path, alert: "Must be logged in."
      end
    end

    def authorize
      unless current_user.role == "instructor"
        return redirect_to root_path, alert: "Must be an instructor."
      end
    end
  end
end
