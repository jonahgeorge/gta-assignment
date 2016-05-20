require "course_catalog/departments_syncer"

class CourseCatalogSyncer
  def self.perform
    DepartmentsSyncer.perform
  end
end
