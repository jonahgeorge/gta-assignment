module Students
  class Preference < ActiveRecord::Base
    self.table_name = "student_preferences"

    enum :value => {
      :"Favor"             => 3,
      :"Slightly favor"    => 2,
      :"Neutral"           => 1,
      :"Slightly disfavor" => 0,
    }

    validates_presence_of :student_id
    validates_presence_of :course_id
    validates_presence_of :value
    validates_uniqueness_of :student_id, :scope => [:course_id]
  
    belongs_to :course
    belongs_to :student
  end
end
