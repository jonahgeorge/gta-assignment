class Preference < ActiveRecord::Base
  enum value: [:favor, :disfavor]

  validates :user_id, presence: true
  validates :course_id, presence: true
  validates :value, presence: true

  belongs_to :course
  belongs_to :user
end
