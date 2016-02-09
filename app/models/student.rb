class Student < User
  has_many :preferences, class_name: "Students::Preference"
  has_many :skills, class_name: "Students::Skill"
end
