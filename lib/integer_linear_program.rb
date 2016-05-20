require "rulp"

Rulp::log_level = Logger::UNKNOWN
Rulp::print_solver_outputs = false

class IntegerLinearProgram

  def initialize(students, sections, fixed_assignments = {}, fte_per_section = 0.25, students_per_ta = 30)
    @students = students
    @sections = sections
    @fixed_assignments = fixed_assignments
    @fte_per_section = fte_per_section
    @students_per_ta = students_per_ta

    @problem = Rulp::Max(objective)
    enrollment_contraint
    fte_contraint
    skill_contraint
    fixed_assignments_constraint if @fixed_assignments
  end

  def solve
    @problem.cbc(parallel: true)
  end

  def results
    results = {}
    @students.each do |student|
      @sections.each do |section|
        if VAR_b(student.id, section.id).value
          results[:"#{student.id}_#{section.id}"] = "Maybe"
        end
        if @fixed_assignments && @fixed_assignments["#{student.id}_#{section.id}"].in?(["Yes", "No"])
          results[:"#{student.id}_#{section.id}"] = @fixed_assignments["#{student.id}_#{section.id}"]
        end
      end
    end
    results
  end

  private

  def objective
    variables = []

    instructor_student_preferences = {}
    @sections.each do |section|
      if section.instructor
        section.instructor.student_preferences.each do |preference|
          instructor_student_preferences[:"#{preference.student.id}_#{section.id}"] = preference
        end
      end
    end

    @students.each do |student|
      section_preferences =
        student.section_preferences.index_by { |preference| :"#{student.id}_#{preference.section.id}" }

      @sections.each do |section|
        student_score = section_preferences[:"#{student.id}_#{section.id}"].try(:value_raw)
        student_score ||= 1

        instructor_score = instructor_student_preferences[:"#{student.id}_#{section.id}"].try(:value_raw)
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
      experiences = student.experiences.index_by { |experience| :"#{experience.skill_id}" }

      @sections.each do |section|
        section.course.requirements.each do |requirement|
          exp = experiences[:"#{requirement.skill_id}"]
          if exp == nil || exp[:value] < requirement[:value]
            @problem[ VAR_b(student.id, section.id) <= 0 ] # Hardcode to NO
          end
        end
      end
    end
  end

  def fixed_assignments_constraint
    @fixed_assignments.each do |key, value|
      student_id, section_id = key.split("_")
      if value == "Yes"
        @problem[ VAR_b(student_id, section_id) >= 1 ]
      elsif value == "No"
        @problem[ VAR_b(student_id, section_id) <= 0 ]
      end
    end
  end

end
