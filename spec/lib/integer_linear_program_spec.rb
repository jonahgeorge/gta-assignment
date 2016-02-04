require 'rails_helper'
require 'integer_linear_program'

RSpec.describe IntegerLinearProgram do

  # it "works on a limited dataset" do
  #   STUDENTS_PER_TA        = 30
  #   FTE_PER_SECTION        = 0.25
  #   STUDENT_PREFERENCES    = []
  #   INSTRUCTORS            = []
  #   INSTRUCTOR_PREFERENCES = []
  #   
  #   COURSES = [
  #     { "id": 0, "name": "Computers: Applications And Implications" },
  #     { "id": 1, "name": "Computer Science Orientation"             },
  #     { "id": 2, "name": "Website Design"                           },
  #     { "id": 3, "name": "Introduction To Databases"                }
  #   ]
  #   
  #   SECTIONS = [
  #     { "id": 0, "course_id": 0, "current_enrollment": 15 },
  #     { "id": 1, "course_id": 0, "current_enrollment": 30 },
  #     { "id": 2, "course_id": 1, "current_enrollment": 61 },
  #     { "id": 3, "course_id": 2, "current_enrollment": 30 },
  #     { "id": 4, "course_id": 3, "current_enrollment": 35 }
  #   ]
  #   
  #   STUDENTS = [
  #     { "id": 0, "name": "Jonah", "fte": 0.25 },
  #     { "id": 1, "name": "Zane",  "fte": 0.25 },
  #     { "id": 2, "name": "Ty",    "fte": 0.25 },
  #     { "id": 3, "name": "Katie", "fte": 0.50 },
  #     { "id": 4, "name": "Ben",   "fte": 0.25 }
  #   ]
  #   
  #   problem = IntegerLinearProgram.new
  #   problem.solve
  #   problem.print_results
  # end

  it "works with ActiveRecord" do
    STUDENTS_PER_TA = 30
    FTE_PER_SECTION = 0.25
    @sections = Section.all
    @students = User.where(role: "student")
    
    problem = IntegerLinearProgram.new(@students, @sections, FTE_PER_SECTION, STUDENTS_PER_TA)
    problem.solve
    problem.print_results
  end

end
