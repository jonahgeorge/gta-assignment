class Course < ActiveRecord::Base
  default_scope { order(course_number: :asc) }

  belongs_to :department
  has_many :sections
  has_many :requirements

  def label
    "#{department.subject_code} #{course_number} #{name.titlecase}"
  end
end
