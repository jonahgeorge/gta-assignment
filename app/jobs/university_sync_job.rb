class UniversitySyncJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    cc_departments.each do |cc_department|
      department = Department.find_or_create_by(subject_code: cc_department.subject_code)
      department.update_attributes(name: cc_department.name)
      department.save

      DepartmentSyncJob.perform_later(department.id, cc_department.to_json)
    end
  end

  private

    def cc_departments
      departments = OsuCcScraper::University.new
        .departments
        .select { |d| department_whitelist.include?(d.subject_code) }
    end

    def department_whitelist
      [ "CS", "ECE", "ROB", "ENGR" ]
    end

end
