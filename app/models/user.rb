class User < ActiveRecord::Base
  before_validation :set_password, on: :create

  enum role: { student: 0, instructor: 1, administrator: 2 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :preferences
  has_many :skills_users
  has_many :skills, through: :skills_users

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first
    unless user
      user = User.create name: data["name"], email: data["email"]
    end
    user
  end

  def self.students
    where(role: "student")
  end

  def self.instructors
    where(role: "instructor")
  end

  def self.administrators
    where(role: "administrator")
  end

  private

    def set_password
      self.password = Devise.friendly_token[0,20]
    end
end
