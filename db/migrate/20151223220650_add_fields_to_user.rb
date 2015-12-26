class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_admin, :bool, default: false
    add_column :users, :name, :string
  end
end
