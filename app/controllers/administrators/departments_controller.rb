module Administrators
  class DepartmentsController < BaseController
    def index
      @departments = Department.all
    end

    def show
      @department = Department.find(params[:id])
    end
  end
end
