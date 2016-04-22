require 'integer_linear_program'

class SpringIlp

  def initialize
  end

  def run
    puts "Fetching data..."
    students = User.joins(:section_preferences).students
    sections = Section.joins(course: :department).all

    puts "Running solver..."
    problem = IntegerLinearProgram.new(students, sections)
    problem.solve
    problem.print_results
  end

end

ilp = SpringIlp.new
ilp.run
