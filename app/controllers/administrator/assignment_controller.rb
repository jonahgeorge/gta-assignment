module Administrator
  class AssignmentController < BaseController

    def index
      # @students = User.where(role: "student")
      # @instructos = User.where(role: "instructor")
      
      @sections = [
        "CS 101", "CS 102", "CS 103", "CS 104", "CS 105", 
        "CS 106", "CS 107", "CS 108", "CS 109", "CS 110",
        "CS 101", "CS 102", "CS 103", "CS 104", "CS 105", 
        "CS 106", "CS 107", "CS 108", "CS 109", "CS 110",
        "CS 101", "CS 102", "CS 103", "CS 104", "CS 105", 
        "CS 106", "CS 107", "CS 108", "CS 109", "CS 110",
      ]
      @students = ["Jonah George", "Katie Gifford",  "Ty Skelton", "Tyler Hoppe",
        "JJ Carlos", "John Bourgeious", "Michael McDonald"]
    end

  end
end
