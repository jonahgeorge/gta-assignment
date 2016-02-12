module Instructors
  class Preference < ActiveRecord::Base
    self.table_name = "instructor_preferences"

    enum value: {
      :"Favor"             => 3,
      :"Slightly favor"    => 2,
      :"Neutral"           => 1,
      :"Slightly disfavor" => 0,
      :"Disfavor"          => -999,
    }

    validates_uniqueness_of :student_id, scope: [:section_id, :instructor_id]

    validates_presence_of :instructor_id
    validates_presence_of :section_id
    validates_presence_of :student_id
    validates_presence_of :value

    belongs_to :section
    belongs_to :instructor
    belongs_to :student
  end
end
