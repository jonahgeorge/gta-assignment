class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def synchronize
    # Queue ActiveJob
    redirect_to courses_path
  end
end
