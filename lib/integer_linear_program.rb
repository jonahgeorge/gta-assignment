require "rulp"

Rulp::log_level = Logger::UNKNOWN
Rulp::print_solver_outputs = false

class IntegerLinearProgram

  def initialize(students, sections, fte_per_section = 0.25, students_per_ta = 30)
    @students = students
    @sections = sections
    @fte_per_section = fte_per_section
    @students_per_ta = students_per_ta

    @problem = Rulp::Max(10 * X_i)


    objective_variables = []
    enrollment_constraint_variables = []
    @students.each do |student|
      puts "Processing #{student.full_name}..."
      # fte_contraint(student)
      fte_constraint_variables = []
      # skill_contraint(student)

      # Constructing student_section_preferences
      section_preferences =
        student.section_preferences.index_by { |preference| "#{student.id}_#{preference.section.id}" }

      experiences =
        student.experiences.index_by { |experience| "#{experience.skill_id}" }

      @sections.each do |section|
        fte_constraint_variables << VAR_b(student.id, section.id)

        enrollment_contraint(section) # Rescan students, should remove

        # Constructing instructor_student_preferences hash
        if section.instructor
          instructor_student_preferences =
            section.instructor.student_preferences.index_by { |preference| "#{preference.student.id}_#{section.id}" }
        else
          instructor_student_preferences = {}
        end
        student_score = section_preferences["#{student.id}_#{section.id}"].try(:value_raw)
        student_score ||= 1
        instructor_score = instructor_student_preferences["#{student.id}_#{section.id}"].try(:value_raw)
        instructor_score ||= 1
        objective_variables << (student_score * instructor_score * VAR_b(student.id, section.id))

        # Skill constraint
        section.course.requirements.each do |requirement|
          exp = experiences["#{requirement.skill_id}"]
          if exp == nil || exp[:value] < requirement[:value]
            @problem[ VAR_b(student.id, section.id) <= 0 ] # Hardcode to NO
          end
        end
      end

      fte_constraint_equation = (fte_constraint_variables.sum <= (student.fte / @fte_per_section))
      @problem[ fte_constraint_equation ]

    end

    # puts "Constructing objective..."
    @problem.objective = objective_variables.sum
  end

  def solve
    puts "Running CBC..."
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

  def hash_array_results
    results = {}
    @students.each do |student|
      @sections.each do |section|
        if VAR_b(student.id, section.id).value
          results["#{student.id}_#{section.id}"] = true
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

  def enrollment_contraint(section)
    # @sections.each do |section|
      enrollment_contraint_variables = @students.map { |student| VAR_b(student.id, section.id) }
      enrollment_contraint_equation = (enrollment_contraint_variables.sum <= (section.current_enrollment / @students_per_ta))
      @problem[ enrollment_contraint_equation ]
    # end
  end

  # def fte_contraint(student)
  #   # @students.each do |student|
  #     fte_constraint_variables = @sections.map { |section| VAR_b(student.id, section.id) }
  #     fte_constraint_equation = (fte_constraint_variables.sum <= (student.fte / @fte_per_section))
  #     @problem[ fte_constraint_equation ]
  #   # end
  # end
  #
  # def skill_contraint(student)
  #   # @students.each do |student|
  #     @sections.each do |section|
  #       section.course.requirements.each do |requirement|
  #         exp = student.experiences.where(skill_id: requirement.skill_id).first
  #         if exp == nil || exp[:value] < requirement[:value]
  #           given[ VAR_b(student.id, section.id) <= 0 ] # Hardcode to NO
  #         end
  #       end
  #     end
  #   # end
  # end

end
