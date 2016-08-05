class SectionsSyncer
  def self.perform(course_id, cc_course_json)
    cc_course = OsuCcScraper::Course.from_json(cc_course_json)

    cc_sections(cc_course).each do |cc_section|
      section = Section.find_or_create_by(crn: cc_section.crn)
      section.update_attributes({
        :cc_instructor_tag  => cc_section.instructor,
        :course_id          => course_id,
        :location           => section_location(cc_section.campus),
        :term               => cc_section.term,
        :section            => cc_section.section,
        :type               => cc_section.type,
        :status             => cc_section.status,
        :current_enrollment => cc_section.current,
        :max_enrollment     => cc_section.capacity,
      })
      section.save
    end
  end

  private

    def self.cc_sections(cc_course)
      cc_course.sections.select { |s|
        section_whitelist.include?(s.campus)
      }
    end

    def self.section_whitelist
      [ "Corv", "Ecampus-Distance Education-LD", "Ecampus-Distance Education-UD" ]
    end

    def self.section_location(campus)
      (campus == "Corv") ? "On campus" : "Ecampus"
    end

end
