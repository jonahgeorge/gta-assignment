class Department < ActiveRecord::Base
  default_scope { where(subject_code: ["CS", "ECE"]) }

  has_many :courses
end
