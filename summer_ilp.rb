require 'integer_linear_program'

class SpringIlp

  def initialize
    puts "Seeding data..."
    seed_instructors
    seed_departments
    seed_courses
    seed_sections
    seed_students
    seed_section_preferences
  end

  def run
    puts "Fetching data..."
    students = User.includes([{section_preferences: :section}, :experiences]).gtas
    sections = Section.includes(
      {course: [:requirements, :department]},
      {instructor: :student_preferences}, :section_preferences)
      .with_current_term

    puts "Running solver..."
    problem = IntegerLinearProgram.new(students, sections)
    problem.solve
    puts problem.inspect
    puts problem.results
  end

private

  def seed_instructors
  end

  def seed_student_preferences
  end

  def seed_departments
    @computer_science = Department.create! subject_code: "CS"
  end

  def seed_courses
    @course_290 = Course.create! department: @computer_science, course_number: 290
  end

  def seed_sections
    @section_a = Section.create! current_enrollment: 30, location: 1, term: 'Sp16', course: @course_290, cc_instructor_tag: "Something else"
    @section_b = Section.create! current_enrollment: 30, location: 1, term: 'Sp16', course: @course_290, cc_instructor_tag: "Something else"
  end

  def seed_students
    @keeley_abbott = User.create! first_name: 'Keeley', last_name: 'Abbott', fte: 0.25, email: 'keeley_abbott@oregonstate.edu', cc_instructor_tag: 'N/A'
    @caius_brindescu = User.create! first_name: 'Caius', last_name: 'Brindescu', fte: 0.49, email: 'caius_brindescu@oregonstate.edu', cc_instructor_tag: 'N/A'
  end

  def seed_section_preferences
    # @keeley_abbott.section_preferences.create! section: @section_a, value: 3
    @caius_brindescu.section_preferences.create! section: @section_a, value: 4
    @caius_brindescu.section_preferences.create! section: @section_b, value: 4
  end

end

ilp = SpringIlp.new
ilp.run
