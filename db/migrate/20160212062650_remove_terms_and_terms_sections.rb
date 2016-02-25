class RemoveTermsAndTermsSections < ActiveRecord::Migration
  def change
    drop_table :terms
    drop_table :terms_sections
  end
end
