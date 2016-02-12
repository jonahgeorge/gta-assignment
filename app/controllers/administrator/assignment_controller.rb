module Administrator
  class AssignmentController < BaseController
    def index
      @students = User.where(role: "student")
      @instructos = User.where(role: "instructor")

    end
  end
end
