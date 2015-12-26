class CreateJoinTablesForSkills < ActiveRecord::Migration
  def change
    create_join_table :users, :skills
    create_join_table :courses, :skills
  end
end
