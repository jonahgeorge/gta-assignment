class AddFteToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fte, :float, default: 0 
  end
end
