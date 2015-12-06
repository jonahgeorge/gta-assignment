class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.references :department, index: true

      t.timestamps null: false
    end
    add_foreign_key :courses, :departments
  end
end
