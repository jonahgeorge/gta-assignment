require "rulp"

Rulp::log_level = Logger::UNKNOWN
Rulp::print_solver_outputs = false

class IntegerLinearProgram
  attr_accessor :students, :sections, :assignments_fte, :assignments_is_fixed
  attr_accessor :fte_per_section, :students_per_ta, :lower_fte_bound, :fte_per_student
  attr_accessor :problem

  def initialize(students, sections, assignments_fte = {}, assignments_is_fixed = {}, fte_per_section = 0.25, students_per_ta = 30, lower_fte_bound = 0.20)
    self.students             = students
    self.sections             = sections
    self.assignments_fte      = assignments_fte
    self.assignments_is_fixed = assignments_is_fixed
    self.fte_per_section      = fte_per_section
    self.students_per_ta      = students_per_ta
    self.fte_per_student      = fte_per_section / students_per_ta
    self.lower_fte_bound      = lower_fte_bound

    self.problem = Rulp::Max(objective)
    enrollment_contraint
    fte_contraint
    skill_contraint
    lower_bounds_constraint
    fixed_assignments_constraint
  end

  def solve
    self.problem.cbc(parallel: true, node_limit: 10_000, gap: 0.05, open_definition: true)
  end

  def results
    results = {}
    self.students.each do |student|
      self.sections.each do |section|
        results[:"#{student.id}_#{section.id}"] = VAR_f(student.id, section.id).value
      end
    end
    results
  end

  def inspect
    self.problem.inspect
  end

  def print_results
    self.students.each do |student|
      puts "#{student.full_name} (#{student.fte})"
      self.sections.each do |section|
        if VAR_f(student.id, section.id).value > 0
          puts "\t #{section.course.label} #{section.location} (#{VAR_f(student.id, section.id).value})"
        end
      end
      puts
    end
  end

private

  def objective
    variables = []

    instructor_student_preferences = {}
    self.sections.each do |section|
      if section.instructor
        section.instructor.student_preferences.each do |preference|
          instructor_student_preferences[:"#{preference.student.id}_#{section.id}"] = preference
        end
      end
    end

    self.students.each do |student|
      section_preferences =
        student.section_preferences.index_by { |preference| :"#{student.id}_#{preference.section.id}" }

      self.sections.each do |section|
        student_score = section_preferences[:"#{student.id}_#{section.id}"].try(:value_raw)
        student_score ||= 1

        instructor_score = instructor_student_preferences[:"#{student.id}_#{section.id}"].try(:value_raw)
        instructor_score ||= 1

        variables << (student_score * instructor_score * VAR_f(student.id, section.id))
      end
    end

    variables.sum
  end

  def enrollment_contraint
    self.sections.each do |section|
      variables = self.students.map { |student| VAR_f(student.id, section.id) }
      constraint = (variables.sum <= (section.current_enrollment * self.fte_per_student))
      self.problem[ constraint ]
    end
  end

  def fte_contraint
    self.students.each do |student|
      variables = self.sections.map { |section| VAR_f(student.id, section.id) }
      constraint = (variables.sum <= student.fte)
      self.problem[ constraint ]
    end
  end

  # "Big M Method"
  # https://en.wikipedia.org/wiki/Big_M_method
  # http://stackoverflow.com/questions/24449959/linear-programming-constraint-x-c-or-x-0
  # self.problem[ VAR_f(student.id, section.id) ==    0 ] OR
  # self.problem[ VAR_f(student.id, section.id) >= 0.10 ]
  def lower_bounds_constraint
    self.students.each do |student|
      self.sections.each do |section|
        self.problem[ VAR_f(student.id, section.id) - self.lower_fte_bound * VAR_b(student.id, section.id, "bool") >= 0 ]
        self.problem[ VAR_f(student.id, section.id) - 10 * VAR_b(student.id, section.id, "bool") <= 0 ]
      end
    end
  end

  def skill_contraint
    self.students.each do |student|
      experiences = student.experiences.index_by { |experience| :"#{experience.skill_id}" }

      self.sections.each do |section|
        section.course.requirements.each do |requirement|
          exp = experiences[:"#{requirement.skill_id}"]
          if exp == nil || exp[:value] < requirement[:value]
            self.problem[ VAR_f(student.id, section.id) <= 0 ] # Hardcode to NO
            self.problem[ VAR_f(student.id, section.id) >= 0 ] # Hardcode to NO
          end
        end
      end
    end
  end

  def fixed_assignments_constraint
    self.assignments_is_fixed.each do |key, value|
      student_id, section_id = key.split("_")
      self.problem[ VAR_f(student_id, section_id) <= self.assignments_fte["#{student_id}_#{section_id}"] ]
      self.problem[ VAR_f(student_id, section_id) >= self.assignments_fte["#{student_id}_#{section_id}"] ]
    end
  end

end
