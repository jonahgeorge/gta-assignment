class CourseSyncJob < ActiveJob::Base
  queue_as :default

  def perform(department, course)
    @department = department
    @course = course

    results.each do |row|
      @row = row
      @section = find_section

      if @section
        @section.update_attributes(section_params)
      else
        @section = Section.new(section_params) 
      end

      @section.save
    end
  end

  private

  def results
    OsuCcScraper::Course.new({
      subject_code:  @department.subject_code,
      course_number: @course.course_number,
    }).sections
  end

  # TODO Max unique on either CRN or section_number + term
  def find_section
    Section.joins(course: :department).where({
      number:                     @row.number,
      term:                       @row.term,
      'departments.subject_code': @department.subject_code,
      'courses.course_number':    @course.course_number,
    }).first
  end

  def section_params
    {
      course_id:          @course.id,
      number:             @row.number,
      max_enrollment:     @row.capacity,
      current_enrollment: @row.availability,
      term:               @row.term,
      instructor:         @row.instructor,
    }
  end

end
