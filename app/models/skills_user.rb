# This model represents the join table between `skills` and `users`
class SkillsUser < ActiveRecord::Base
  belongs_to :skill
  belongs_to :user

  validate :max_skill_count
  def max_skill_count
    errors.add(:user, "cannot have more than 5 skills") if user.skills_users.count >= 5
  end
end
