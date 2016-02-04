class ChangePreferencesValueToInteger < ActiveRecord::Migration
  def change
    change_column :preferences, :value, :integer
  end
end
