require "course_catalog/sections_syncer"

class CoursesSyncer
  def self.perform(department_id, cc_department_json)
    cc_department = OsuCcScraper::Department.from_json(cc_department_json)

    cc_courses(cc_department).each do |cc_course|
      course = Course.find_or_create_by(department_id: department_id, course_number: cc_course.course_number)
      course.update_attributes(name: cc_course.name)
      course.save

      SectionsSyncer.perform(course.id, cc_course.to_json)
    end
  end

  private

    def self.cc_courses(cc_department)
      cc_department.courses.select { |c|
        course_whitelist.include?("#{cc_department.subject_code} #{c.course_number}")
      }
    end

    def self.course_whitelist
      [
        "CS 225", "CS 261", "CS 271", "CS 290", "CS 295", "CS 325", "CS 331", "CS 340", "CS 344",
        "CS 352", "CS 361", "CS 362", "CS 372", "CS 381", "CS 391", "CS 419", "CS 434", "CS 444",
        "CS 463", "CS 472", "CS 475", "CS 478", "CS 496", "CS 517", "CS 519", "CS 523", "CS 533",
        "CS 544", "CS 551", "CS 569", "CS 572", "CS 575", "CS 583", "CS 589", "ECE 271", "ECE 323",
        "ECE 352", "ECE 353", "ECE 372", "ECE 391", "ECE 413", "ECE 415", "ECE 418", "ECE 431",
        "ECE 432", "ECE 437", "ECE 443", "ECE 463", "ECE 472", "ECE 474", "ECE 477", "ECE 478",
        "ECE 483", "ECE 485", "ECE 518", "ECE 520", "ECE 531", "ECE 532", "ECE 537", "ECE 563",
        "ECE 572", "ECE 574", "ECE 577", "ECE 583", "ECE 585", "ECE 599", "ECE 613", "ECE 627",
        "ECE 669", "ENGR 201", "ENGR 202", "ENGR 203", "ROB 421", "ROB 521"
      ]
    end

end
