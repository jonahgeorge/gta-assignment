class Section < ActiveRecord::Base
  enum location: {
    :"On campus" => 0,
    :"Ecampus"   => 1
  }

  validates_uniqueness_of :course_id, scope: [:instructor, :location]

  belongs_to :instructor, class_name: "User", 
    foreign_key: "cc_instructor_tag", primary_key: "cc_instructor_tag"
  belongs_to :course
  has_and_belongs_to_many :terms
  has_many :student_preferences
  has_many :section_preferences
end
