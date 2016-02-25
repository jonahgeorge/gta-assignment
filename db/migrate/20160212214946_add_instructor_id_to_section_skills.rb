class AddInstructorIdToSectionSkills < ActiveRecord::Migration
  def change
    add_column :courses_skills, :instructor_id, :integer
  end
end
