require "course_catalog/course_catalog_syncer"

desc "This task is called by the Heroku scheduler add-on"
task :sync_course_catalog => :environment do
  CourseCatalogSyncer.perform
end
