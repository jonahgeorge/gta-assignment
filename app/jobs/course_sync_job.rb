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
        section[:current_enrollment] += (row.capacity.to_i - row.availability.to_i)
        section[:max_enrollment] += row.capacity.to_i
      else
        sections << { 
          :instructor         => row.instructor, 
          :course_id          => @course.id, 
          :location           => section_location(row), 
          :term               => row.term,
          :current_enrollment => (row.capacity.to_i - row.availability.to_i), 
          :max_enrollment     => row.capacity.to_i,
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
      sections.select{ |s| s[:instructor] == instructor && s[:course_id] == course_id && s[:location] == location && s[:term] == term }.first
    end

    def section_location(row)
      return "Ecampus" if row.term == "WWW" 
      return "On campus"
    end

    def results
      params = { :subject_code  => @department.subject_code, :course_number => @course.course_number, }    
      OsuCcScraper::Course.new(params).sections
    end

    def find_section(section)
      params = {
        :instructor => section[:instructor],
        :location   => section[:location],
        :course_id  => section[:course_id],
      }
      Section.joins(course: :department).where(params).first
    end

end
