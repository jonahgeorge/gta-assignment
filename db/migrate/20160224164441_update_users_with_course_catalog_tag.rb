class UpdateUsersWithCourseCatalogTag < ActiveRecord::Migration
  def change
    add_column :users, :course_catalog_instructor_tag, :string
  end
end
