class UniversitySyncJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    results.each do |row|
      department = Department.find_by_subject_code(row.subject_code)

      if department
        department.update_attributes(department_params(row))
      else
        department = Department.new(department_params(row))
      end

      department.save

      DepartmentSyncJob.perform_later(department)
    end
  end

  private

    def results
      whitelist = [ "CS", "ECE", "ROB", "ENGR" ]
      OsuCcScraper::University.new
        .departments
        .select { |d| whitelist.include?(d.subject_code) }
    end

    def department_params(row)
      { name: row.name, subject_code: row.subject_code, }
    end
end
