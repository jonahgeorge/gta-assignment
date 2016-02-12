class Section < ActiveRecord::Base
  enum location: {
    :"On campus" => 0,
    :"Ecampus"   => 1
  }

  validates_uniqueness_of :course_id, scope: [:instructor, :location]

  belongs_to :course
  has_and_belongs_to_many :terms
  has_many :instructor_preferences, class_name: "Instructors::Preference"
  has_many :student_preferences, class_name: "Students::Preference"
end
