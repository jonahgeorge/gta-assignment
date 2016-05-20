class AddFieldsToSections < ActiveRecord::Migration
  def change
    add_column :sections, :section, :string
    add_column :sections, :type, :string
    add_column :sections, :status, :string
  end
end
