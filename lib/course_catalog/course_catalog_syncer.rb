require "course_catalog/departments_syncer"

class CourseCatalogSyncer
  def self.perform
    # Clear stale data
    Section.delete_all
    Course.delete_all
    Department.delete_all

    DepartmentsSyncer.perform
  end
end
