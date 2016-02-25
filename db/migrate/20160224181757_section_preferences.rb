class SectionPreferences < ActiveRecord::Migration
  def change
    rename_column :student_preferences, :course_id, :section_id
  end
end
