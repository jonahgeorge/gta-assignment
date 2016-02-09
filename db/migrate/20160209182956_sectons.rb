class Sectons < ActiveRecord::Migration
  def change
    remove_column :sections, :location
    add_column :sections, :location, :integer
    remove_column :sections, :term
    remove_column :sections, :number
  end
end
