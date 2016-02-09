class CourseSyncJob < ActiveJob::Base
  queue_as :default

  # FIXME, for unique (location, course_id, instructor_id), 
  # keep running sum of current_enrollment and max_enrollment
  #
  # If section exists, update. 
  # If section does not exists, insert
  #
  # If term exists, create join_table record
  # If term does not exist, create Term and join_table record
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
      params = {
        "subject_code":  @department.subject_code,
        "course_number": @course.course_number,
      }    
      OsuCcScraper::Course.new(params).sections
    end

    # TODO Max unique on either CRN or section_number + term
    def find_section
      params = {
        "number":                   @row.number,
        "term":                     @row.term,
        "departments.subject_code": @department.subject_code,
        "courses.course_number":    @course.course_number
      }
      Section.joins(course: :department).where(params).first
    end

    # FIXME If type == "WWW", location = "e_campus"
    def section_params
      {
        "course_id":          @course.id,
        "number":             @row.number,
        "max_enrollment":     @row.capacity,
        "current_enrollment": @row.availability,
        "term":               @row.term,
        "instructor":         @row.instructor,
      }
    end

end
