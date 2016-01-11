module Administrator
  class CoursesController < BaseController
    def index
      @courses = Course.includes(:department).all
    end

    def show
      @course = Course.includes(:department).find(params[:id])
    end
  end
end
