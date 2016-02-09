class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.integer :season
      t.integer :year 
      t.timestamps
    end
  end
end
