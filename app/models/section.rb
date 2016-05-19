class Section < ActiveRecord::Base
  self.inheritance_column = nil

  enum location: {
    :"On campus" => 0,
    :"Ecampus"   => 1
  }

  scope :with_current_term, -> { where(term: Setting.current_term) }

  # validates_uniqueness_of :course_id, scope: [:instructor, :location, :term]

  belongs_to :instructor, class_name: "User",
    foreign_key: "cc_instructor_tag", primary_key: "cc_instructor_tag"
  belongs_to :course
  # has_many :student_preferences
  # has_many :section_preferences
end
