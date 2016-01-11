# This model represents the join table between `courses` and `skills`
class CoursesSkill < ActiveRecord::Base
  belongs_to :skill
  belongs_to :course
end
