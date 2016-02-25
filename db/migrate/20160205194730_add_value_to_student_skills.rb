class AddValueToStudentSkills < ActiveRecord::Migration
  def change
    add_column :student_skills, :value, :integer
  end
end
