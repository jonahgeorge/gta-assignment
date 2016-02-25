class TermsSections < ActiveRecord::Migration
  def change
    create_table :terms_sections, id: false do |t|
      t.integer :term_id
      t.integer :section_id
    end
  end
end
