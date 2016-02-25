class SectionPreference < ActiveRecord::Base
  self.table_name = "student_preferences"

  enum value: {
    :"Disfavor"          => 0,
    :"Slightly disfavor" => 1,
    :"Neutral"           => 2,
    :"Slightly favor"    => 3,
    :"Favor"             => 4,
  }

  def value_raw
    read_attribute('value')
  end

  validates_uniqueness_of :student_id, scope: [:section_id]

  validates_presence_of :student_id
  validates_presence_of :section_id
  validates_presence_of :value

  belongs_to :section
  belongs_to :student, class_name: "User"
end
