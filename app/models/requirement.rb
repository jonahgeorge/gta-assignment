class Requirement < ActiveRecord::Base
  self.table_name = "courses_skills"

  enum :value => {
    :"Qualified"          => 2,
    :"Slightly qualified" => 1,
    :"Unqualified"        => 0,
  }

  belongs_to :skill
  belongs_to :course
  belongs_to :instructor

  validates_uniqueness_of :skill_id, scope: [:course_id]
  validates_presence_of :skill_id, :course_id, :instructor_id, :value

end
