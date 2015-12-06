class DepartmentsController < ApplicationController
  def index
    @departments = Department.all
  end

  def synchronize
    redirect_to departments_path
  end
end
