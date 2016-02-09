class RenameSkillsUserToStudentSkills < ActiveRecord::Migration
  def change
    rename_table :skills_users, :student_skills
  end
end
