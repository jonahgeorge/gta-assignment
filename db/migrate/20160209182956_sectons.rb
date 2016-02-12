class Sectons < ActiveRecord::Migration
  def change
    remove_column :sections, :location, :string
    add_column :sections, :location, :integer
    remove_column :sections, :number, :string
  end
end
