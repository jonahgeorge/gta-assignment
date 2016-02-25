class FixSti < ActiveRecord::Migration
  def change
    rename_column :student_preferences, :student_id, :user_id
    rename_column :student_skills, :student_id, :user_id
    rename_column :courses_skills, :instructor_id, :user_id
  end
end
