class UndoFixSti < ActiveRecord::Migration
  def change
    rename_column :student_skills, :user_id, :student_id
    rename_column :courses_skills, :user_id, :instructor_id
    rename_column :student_preferences, :user_id, :student_id
  end
end
