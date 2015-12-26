module Admin
  class ApplicationController < ::ApplicationController

    def synchronize
      CourseCatalogSyncJob.perform_later
      redirect_to root_path
    end

  end
end
