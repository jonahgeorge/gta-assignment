# FIXME Refactor with `find_or_create_by_value`
class CourseSyncJob < ActiveJob::Base
  queue_as :default

  def perform(department, course)
    @department = department
    @course = course

    sections = []

    # Aggregate sections based on Prasad's tuple (instructor, course_id, location)
    # and keep running-sum of current_enrollment and max_enrollment
    results.each do |row|
      section = find_sections_by_tuple(sections, row.instructor, @course.id, section_location(row), row.term)
      if section
        section[:current_enrollment] += row.current
        section[:max_enrollment] += row.capacity
      else
        sections << {
          :cc_instructor_tag  => row.instructor,
          :course_id          => @course.id,
          :location           => section_location(row),
          :term               => row.term,
          :current_enrollment => row.current,
          :max_enrollment     => row.capacity,
        }
      end
    end

    # Save sections
    sections.each do |section|
      @section = find_section(section)
      if @section
        @section.update_attributes(section)
      else
        @section = Section.new(section)
      end
      @section.save
    end
  end

  private

    def find_sections_by_tuple(sections, instructor, course_id, location, term)
      sections.select{ |section| 
        section[:instructor] == instructor && 
        section[:course_id] == course_id && 
        section[:location] == location && 
        section[:term] == term 
      }.first
    end

    def section_location(row)
      return "Ecampus" if row.term == "WWW"
      return "On campus"
    end

    def results
      OsuCcScraper::Course.new(
        @department.subject_code, @course.course_number).sections
    end

    def find_section(section)
      params = {
        cc_instructor_tag: section[:instructor],
        location:          section[:location],
        course_id:         section[:course_id],
      }
      Section.joins(course: :department).where(params).first
    end

end
