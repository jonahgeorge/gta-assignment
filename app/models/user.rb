class User < ActiveRecord::Base
  before_validation :set_password, on: :create

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :omniauthable,
         :omniauth_providers => [:google_oauth2]

  has_many :student_preferences, foreign_key: "instructor_id"
  has_many :section_preferences, foreign_key: "student_id"
  has_many :experiences, ->{ joins(:skill) }, foreign_key: "student_id"
  has_many :sections, foreign_key: "cc_instructor_tag", primary_key: "cc_instructor_tag"

  def self.instructors
    where(cc_instructor_tag: Section.select(:cc_instructor_tag).with_current_term)
  end

  def self.students
    where.not(cc_instructor_tag: Section.select(:cc_instructor_tag).with_current_term)
  end

  def self.gtas
    students.where('fte > 0')
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data["email"]).first
    unless user
      user = User.create({
        first_name: data["first_name"],
        last_name: data["last_name"],
        email: data["email"],
        cc_instructor_tag: "#{data["last_name"]}, #{data["first_name"][0]}."
      })
    end
    user
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def is_student
    self.sections.with_current_term.length == 0
  end

  def is_instructor
    self.sections.with_current_term.length > 0
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
