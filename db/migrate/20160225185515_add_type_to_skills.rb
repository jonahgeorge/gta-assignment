class AddTypeToSkills < ActiveRecord::Migration
  def change
    add_column :skills, :type, :integer
  end
end
