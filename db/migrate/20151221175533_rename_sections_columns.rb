class RenameSectionsColumns < ActiveRecord::Migration
  def change
    add_column :sections, :term, :string
    rename_column :sections, :capacity, :max_enrollment
    rename_column :sections, :availability, :current_enrollment
  end
end
