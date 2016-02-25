class Section < ActiveRecord::Base

  enum location: {
    :"On campus" => 0,
    :"Ecampus"   => 1
  }

  def instructor_raw
    read_attribute('instructor')
  end

  validates_uniqueness_of :course_id, scope: [:instructor, :location]

  belongs_to :instructor, class_name: "User", foreign_key: "instructor",
    primary_key: "course_catalog_instructor_tag"
  belongs_to :course
  has_and_belongs_to_many :terms
  has_many :student_preferences
  has_many :section_preferences
end
