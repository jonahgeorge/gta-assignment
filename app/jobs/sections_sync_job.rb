class SectionsSyncJob < ActiveJob::Base
  queue_as :default

  def perform(course_id, cc_course_json)
    cc_course = OsuCcScraper::Course.from_json(cc_course_json)

    section_tuples = construct_tuples(course_id, cc_course)

    section_tuples.each do |section_tuple|
      section = Section.find_or_create_by(section_params(section_tuple))
      section.update_attributes(section_tuple)
      section.save
    end
  end

  private

    def construct_tuples(course_id, cc_course)
      section_tuples = []

      # Aggregate sections based on Prasad's tuple (instructor, course_id, location)
      # and keep running-sum of current_enrollment and max_enrollment
      cc_sections(cc_course).each do |cc_section|

        section_tuple = find_section_by_tuple(
          section_tuples, cc_section.instructor, course_id,
          section_location(cc_section), cc_section.term)

        if section_tuple
          section_tuple[:current_enrollment] += cc_section.current
          section_tuple[:max_enrollment] += cc_section.capacity
        else
          section_tuples << {
            :cc_instructor_tag  => cc_section.instructor,
            :course_id          => course_id,
            :location           => section_location(cc_section),
            :term               => cc_section.term,
            :current_enrollment => cc_section.current,
            :max_enrollment     => cc_section.capacity,
          }
        end
      end

      section_tuples
    end

    def find_section_by_tuple(section_tuples, instructor, course_id, location, term)
      section_tuples.select { |section_tuple|
        section_tuple[:instructor] == instructor &&
        section_tuple[:course_id] == course_id &&
        section_tuple[:location] == location &&
        section_tuple[:term] == term
      }.first
    end

    def cc_sections(cc_course)
      cc_course.sections.select { |s|
        section_whitelist.include?(s.campus)
      }
    end

    def section_whitelist
      [ "Corv", "Ecampus-Distance Education-LD" ]
    end

    def section_location(cc_section)
      (cc_section.campus == "Corv") ? "On campus" : "Ecampus"
    end

    def section_params(section_tuple)
      {
        cc_instructor_tag: section_tuple[:instructor],
        location:          section_tuple[:location],
        course_id:         section_tuple[:course_id],
        term:              section_tuple[:term]
      }
    end

end
