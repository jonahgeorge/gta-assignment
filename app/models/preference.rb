class Preference < ActiveRecord::Base
  enum value: { favor: 0, disfavor: 1 }

  validates :user_id, presence: true
  validates :course_id, presence: true
  validates :value, presence: true

  belongs_to :course
  belongs_to :user

  validate :max_preference_count
  def max_preference_count
    errors.add(:user, "cannot have more than 5 preferences") if user.preferences.count >= 5
  end
end
