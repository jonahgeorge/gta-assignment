class RenameTables < ActiveRecord::Migration
  def change
    rename_table :student_preferences, :section_preferences
    rename_table :instructor_preferences, :student_preferences
    rename_table :courses_skills, :requirements
    rename_table :student_skills, :experiences
  end
end
