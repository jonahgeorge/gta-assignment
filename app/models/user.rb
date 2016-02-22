class User < ActiveRecord::Base

  before_validation :set_password, on: :create

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :preferences, class_name: "Students::Preference"
  has_many :skills, class_name: "Students::Skill"
  has_many :sections, -> (object) { 
    where(instructor: "#{object.last_name}, #{object.first_name[0]}.")
  }, foreign_key: 'instructor'

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data["email"]).first
    unless user
      user = User.create(first_name: data["first_name"], last_name: data["last_name"], email: data["email"])
    end
    user
  end

  def is_student
    self.sections.length == 0
  end

  def is_instructor
    self.sections.length > 0
  end

  def is_administrator
    true
  end

  def role
    if is_student
      "Student"
    elsif is_instructor
      "Instructor"
    elsif is_administrator
      "Administrator"
    end
  end

  private

    def set_password
      self.password = Devise.friendly_token[0,20]
    end
end
