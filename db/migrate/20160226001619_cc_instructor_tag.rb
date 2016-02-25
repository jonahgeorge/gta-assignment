class CcInstructorTag < ActiveRecord::Migration
  def change
    rename_column :users, :course_catalog_instructor_tag, :cc_instructor_tag
    rename_column :sections, :instructor, :cc_instructor_tag
  end
end
