module Admin
  class ReportsController < ApplicationController
    def preferences
      @users = User.where(is_admin: false)

      respond_to do |format|
        format.html
        format.pdf { render pdf: "preferences" } 
      end
    end
  end
end
