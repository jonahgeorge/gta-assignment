class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :number
      t.string :location
      t.integer :capacity
      t.integer :availability
      t.references :course, index: true
      t.string :instructor

      t.timestamps null: false
    end
    add_foreign_key :sections, :courses
  end
end
