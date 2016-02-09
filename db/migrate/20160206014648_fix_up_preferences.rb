class FixUpPreferences < ActiveRecord::Migration
  def change
    rename_table :preferences, :student_preferences
    rename_column :student_preferences, :user_id, :student_id
  end
end
