class Section < ActiveRecord::Base
  validates_uniqueness_of :course_id, scope: [:instructor_id, :location]

  enum location: { on_campus: 0, e_campus: 1 }

  belongs_to :course
  has_and_belongs_to_many :terms
end
