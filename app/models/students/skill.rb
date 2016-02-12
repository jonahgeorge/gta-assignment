module Students
  class Skill < ActiveRecord::Base
    self.table_name = "student_skills"

    enum value: {
      :"Qualified"          => 2,
      :"Slightly qualified" => 1,
      :"Unqualified"        => 0,
    }

    validates_uniqueness_of :student_id, scope: [:skill_id]

    validates_presence_of :student_id
    validates_presence_of :skill_id
    validates_presence_of :value

    belongs_to :skill, class_name: "::Skill"
    belongs_to :student
  end
end
