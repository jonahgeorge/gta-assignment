module Admin
  class DepartmentsController < ApplicationController
    def index
      @departments = Department.all
    end

    def show
      @department = Department.find(params[:id])
    end
  end
end

