module Sections
  class RequiredSkill < ActiveRecord::Base
    self.table_name = "courses_skills"

    belongs_to :skill
    belongs_to :course
  end
end
