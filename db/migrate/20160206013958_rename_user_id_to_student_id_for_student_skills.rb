class RenameUserIdToStudentIdForStudentSkills < ActiveRecord::Migration
  def change
    rename_column :student_skills, :user_id, :student_id
  end
end
