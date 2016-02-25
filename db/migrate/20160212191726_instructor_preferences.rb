class InstructorPreferences < ActiveRecord::Migration
  def change
    create_table :instructor_preferences do |t|
      t.integer :section_id
      t.integer :instructor_id
      t.integer :student_id
      t.integer :value

      t.timestamps
    end
  end
end
