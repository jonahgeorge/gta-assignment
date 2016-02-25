class Requirement < ActiveRecord::Base
  self.table_name = "courses_skills"

  enum value: {
    :"Qualified"          => 2,
    :"Slightly qualified" => 1,
    :"Unqualified"        => 0,
  }

  validates_uniqueness_of :skill_id, scope: [:course_id]

  validates_presence_of :skill_id
  validates_presence_of :course_id
  validates_presence_of :instructor_id
  validates_presence_of :value

  belongs_to :skill
  belongs_to :course
  belongs_to :instructor
end
