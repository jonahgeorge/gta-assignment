class ChangeDefaultValueOfRole < ActiveRecord::Migration
  def change
    change_column :users, :role, :string, :default => "Student"
  end
end
