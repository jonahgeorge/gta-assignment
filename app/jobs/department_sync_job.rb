class DepartmentSyncJob < ActiveJob::Base
  queue_as :default

  def perform(department)
    @department = department

    results.each do |row|
      puts row
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
    whitelist = [
      "CS 225", "CS 225", "CS 225", "CS 261", "CS 261", "CS 271", "CS 290", "CS 295",
      "CS 325", "CS 331", "CS 340", "CS 340", "CS 344", "CS 352", "CS 361", "CS 362",
      "CS 362", "CS 372", "CS 372", "CS 381", "CS 391", "CS 391", "CS 391", "CS 419",
      "CS 419", "CS 434", "CS 444", "CS 463", "CS 472", "CS 475", "CS 475", "CS 478",
      "CS 496", "CS 496", "CS 517", "CS 519", "CS 519", "CS 519", "CS 519", "CS 523",
      "CS 533", "CS 544", "CS 551", "CS 569", "CS 569", "CS 572", "CS 575", "CS 575",
      "CS 583", "CS 589", "ECE 271", "ECE 323", "ECE 352", "ECE 353", "ECE 372",
      "ECE 391", "ECE 413", "ECE 415", "ECE 418", "ECE 431", "ECE 432", "ECE 437",
      "ECE 443", "ECE 463", "ECE 472", "ECE 474", "ECE 477", "ECE 478", "ECE 483",
      "ECE 485", "ECE 518", "ECE 520", "ECE 531", "ECE 532", "ECE 537", "ECE 563",
      "ECE 572", "ECE 574", "ECE 577", "ECE 583", "ECE 585", "ECE 599", "ECE 599",
      "ECE 599", "ECE 599", "ECE 599", "ECE 613", "ECE 627", "ECE 669", "ENGR 201",
      "ENGR 202", "ENGR 203", "ROB 421", "ROB 521",
    ]
    OsuCcScraper::Department.new(@department.name, @department.subject_code)
      .courses
      .select { |c| whitelist.include?("#{@department.subject_code} #{c.course_number}") }
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
