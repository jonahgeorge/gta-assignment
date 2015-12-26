class CourseCatalogSyncJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    results.each do |row|
      @row = row
      @department = find_department

      if @department
        @department.update_attributes(department_params)
      else
        @department = Department.new(department_params) 
      end

      @department.save

      DepartmentSyncJob.perform_later @department
    end
  end

  private

  def results
    OsuCcScraper::Department.all
  end

  def find_department
    Department.where({
      subject_code: @row.subject_code
    }).first
  end

  def department_params
    {
      name:         @row.name,
      subject_code: @row.subject_code,
    }
  end
end
