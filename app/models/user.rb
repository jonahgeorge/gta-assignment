class User < ActiveRecord::Base

  self.inheritance_column = :role
  def self.roles
    %w(Student Instructor Administrator)
  end

  before_validation :set_password, on: :create

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data["email"]).first
    unless user
      user = User.create(name: data["name"], email: data["email"])
    end
    user
  end

  private

    def set_password
      self.password = Devise.friendly_token[0,20]
    end
end
