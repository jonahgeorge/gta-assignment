require "rulp"

Rulp::log_level = Logger::UNKNOWN
Rulp::print_solver_outputs = false

class IntegerLinearProgram 

  def initialize(students, sections, fte_per_section, students_per_ta)
    @students = students
    @sections = sections
    @fte_per_section = fte_per_section
    @students_per_ta = students_per_ta

    @problem = Rulp::Max(objective)
    enrollment_contraint
    fte_contraint
    skill_contraint
    experience_contraint
  end

  def solve
    # @problem.solve
    @problem.cbc
  end

  def results
    results = []
    @students.each do |student|
      @sections.each do |section|
        if VAR_b(student.id, section.id).value
          results << { student_id: student.id, section_id: section.id }
        end
      end
    end
    results
  end

  def print_results
    @students.each do |student|
      puts student.name
      @sections.each do |section|
        if VAR_b(student.id, section.id).value
          puts "\t #{section.course.label}"
        end
      end
      puts
    end
  end

  private

    def objective
      variables = []
      @students.each do |student|
        @sections.each do |section|
          student_score = student.preferences.where(course_id: section.course_id).first.try(:value)
          student_score ||= 1 

          # FIXME
          instructor_score = student.preferences.where(course_id: section.course_id).first.try(:value)
          instructor_score ||= 1 

          variables << (student_score * instructor_score * VAR_b(student.id, section.id))
        end
      end
      variables.sum
    end

    def enrollment_contraint
      @sections.each do |section|
        variables = @students.map { |student| VAR_b(student.id, section.id) }
        constraint = (variables.sum <= (section.current_enrollment / @students_per_ta))
        @problem[ constraint ]
      end
    end

    def fte_contraint
      @students.each do |student| 
        variables = @sections.map { |section| VAR_b(student.id, section.id) }
        constraint = (variables.sum <= (student.fte / @fte_per_section))
        @problem[ constraint ]
      end
    end

    def skill_contraint
      # FIXME
    end

    def experience_contraint
      # FIXME
    end
end

