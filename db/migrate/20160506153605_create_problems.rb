class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.jsonb :assignments, null: false, default: '{}'
      t.timestamps null: false
    end
  end
end
