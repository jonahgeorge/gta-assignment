class SettingsController < ApplicationController
  layout "settings"

  def profile
  end

  def preferences
    @preferences = current_user.preferences
  end

  def skills
    @skills = current_user.skills
  end
end
