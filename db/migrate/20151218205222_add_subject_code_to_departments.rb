class AddSubjectCodeToDepartments < ActiveRecord::Migration
  def change
    add_column :departments, :subject_code, :string
  end
end
