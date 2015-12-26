class DepartmentSyncJob < ActiveJob::Base
  queue_as :default

  def perform(department)
    @department = department

    results.each do |row|
      @row = row
      @course = find_course

      if @course
        @course.update_attributes(course_params)
      else
        @course = Course.new(course_params) 
      end

      @course.save

      CourseSyncJob.perform_later @department, @course
    end
  end

  private

  def results
    OsuCcScraper::Department.new({
      subject_code: @department.subject_code
    }).courses
  end

  def find_course
    Course.joins(:department).where({
      'departments.subject_code': @department.subject_code,
      course_number:              @row.course_number
    }).first
  end

  def course_params 
    {
      name:          @row.name,
      department_id: @department.id,
      course_number: @row.course_number,
    }
  end

end
