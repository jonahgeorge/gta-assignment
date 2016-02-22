module Administrator
  class BaseController < ::ApplicationController
    before_filter :authenticate
    before_filter :authorize

    def synchronize
      CourseCatalogSyncJob.perform_later
      redirect_to root_path
    end

    def authenticate
      unless signed_in?
        return redirect_to root_path, alert: "Must be logged in."
      end
    end

    def authorize
      unless current_user.is_administrator
        return redirect_to root_path, alert: "Must be an administrator."
      end
    end
  end
end
