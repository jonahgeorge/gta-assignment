class UsersIsAdministrator < ActiveRecord::Migration
  def change
    rename_column :users, :is_admin, :is_administrator
  end
end
