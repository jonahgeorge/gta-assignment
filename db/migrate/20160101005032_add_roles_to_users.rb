class AddRolesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :integer
    remove_column :users, :is_admin
  end
end
