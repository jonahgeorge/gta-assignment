class Requirements < ActiveRecord::Migration
  def change
    add_column :courses_skills, :value, :integer
  end
end
