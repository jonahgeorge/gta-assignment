class AddCrnToSections < ActiveRecord::Migration
  def change
    add_column :sections, :crn, :integer
  end
end
