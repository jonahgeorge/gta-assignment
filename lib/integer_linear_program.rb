require "rulp"

Rulp::log_level = Logger::UNKNOWN
Rulp::print_solver_outputs = false

class IntegerLinearProgram

  def initialize(students, sections, fte_per_section = 0.25, students_per_ta = 30)
    @students = students
    @sections = sections
    @fte_per_section = fte_per_section
    @students_per_ta = students_per_ta

    @problem = Rulp::Max(objective)
    enrollment_contraint
    fte_contraint
    skill_contraint
  end

  def solve
    @problem.cbc(parallel: true)
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
      puts student.full_name
      @sections.each do |section|
        if VAR_b(student.id, section.id).value
          puts "\t #{section.course.label} #{section.location}"
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
        student_score =
          student.section_preferences.find_by_section_id(section.id).try(:value_raw)
        student_score ||= 1

        instructor_score =
          student.student_preferences.find_by_section_id(section.id).try(:value_raw)
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
    @students.each do |student|
      @sections.each do |section|
        section.course.requirements.each do |requirement|
          exp = student.experiences.where(skill_id: requirement.skill_id).first
          if exp == nil || exp[:value] < requirement[:value]
            given[ VAR_b(student.id, section.id) <= 0 ] # Hardcode to NO
          end
        end
      end
    end
  end

end
