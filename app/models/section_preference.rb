class SectionPreference < ActiveRecord::Base
  enum value: {
    :"Favor"             => 4,
    :"Slightly favor"    => 3,
    :"Neutral"           => 2,
    :"Slightly disfavor" => 1,
    :"Disfavor"          => 0,
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
