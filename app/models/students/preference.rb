module Students
  class Preference < ActiveRecord::Base
    self.table_name = "student_preferences"

    enum value: {
      favor:             3,
      slightly_favor:    2,
      neutral:           1,
      slightly_disfavor: 0
    }

    validates_presence_of :student_id
    validates_presence_of :course_id
    validates_presence_of :value
    validates_uniqueness_of :student_id, scope: [:course_id]
  
    belongs_to :course
    belongs_to :student
  end
end
