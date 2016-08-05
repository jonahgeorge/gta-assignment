class AddAssignmentsFixedToAssignments < ActiveRecord::Migration
  def change
    rename_column :problems, :assignments, :assignments_fte
    add_column :problems, :assignments_is_fixed, :jsonb, null: false, default: '{}'
  end
end
