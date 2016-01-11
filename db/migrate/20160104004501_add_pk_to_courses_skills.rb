class AddPkToCoursesSkills < ActiveRecord::Migration
  def change
    add_column :courses_skills, :id, :primary_key
  end
end
