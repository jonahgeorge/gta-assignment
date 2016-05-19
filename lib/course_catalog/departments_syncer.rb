require "course_catalog/courses_syncer"

class DepartmentsSyncer
  def self.perform(*args)
    cc_departments.each do |cc_department|
      department = Department.create({
        :subject_code => cc_department.subject_code,
        :name         => cc_department.name,
      })
      department.save

      CoursesSyncer.perform(department.id, cc_department.to_json)
    end
  end

  private

    def self.cc_departments
      departments = OsuCcScraper::University.new
        .departments
        .select { |d| department_whitelist.include?(d.subject_code) }
    end

    def self.department_whitelist
      [ "CS", "ECE", "ROB", "ENGR" ]
    end

end
