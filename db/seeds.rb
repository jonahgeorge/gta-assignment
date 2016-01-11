# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Skills
%w(Python C C++ Haskell Debugging Java Ruby Perl SQL).each do |skill|
  Skill.create name: skill
end

# Departments
Department.create name: "Computer Science", subject_code: "CS"

# Courses
course = Course.create department: Department.find_by_subject_code("CS"), name: "Python", course_number: 100
course.skills << Skill.find_by_name("Python")
course.skills << Skill.find_by_name("Debugging")

course = Course.create department: Department.find_by_subject_code("CS"), name: "Java", course_number: 101
course.skills << Skill.find_by_name("Debugging")
course.skills << Skill.find_by_name("Java")

course = Course.create department: Department.find_by_subject_code("CS"), name: "Databases", course_number: 102
course.skills << Skill.find_by_name("SQL")

# Sections

# Students
user = User.create email: "skelton@oregonstate.edu", name: "John Skelton", role: "student"
user.preferences.create course: Course.find_by_name("Python"), value: "favor"
user.preferences.create course: Course.find_by_name("Java"), value: "disfavor"
user.preferences.create course: Course.find_by_name("Databases"), value: "disfavor"
user.skills << Skill.find_by_name("Ruby")
user.skills << Skill.find_by_name("Perl")

user = User.create email: "george@oregonstate.edu", name: "John George", role: "student"
user.preferences.create course: Course.find_by_name("Python"), value: "disfavor"
user.preferences.create course: Course.find_by_name("Java"), value: "disfavor"
user.preferences.create course: Course.find_by_name("Databases"), value: "favor"
user.skills << Skill.find_by_name("C")
user.skills << Skill.find_by_name("Python")
user.skills << Skill.find_by_name("Ruby")

user = User.create email: "gifford@oregonstate.edu", name: "Jane Gifford", role: "student"
user.preferences.create course: Course.find_by_name("Python"), value: "disfavor"
user.preferences.create course: Course.find_by_name("Java"), value: "favor"
user.preferences.create course: Course.find_by_name("Databases"), value: "favor"
user.skills << Skill.find_by_name("Ruby")
user.skills << Skill.find_by_name("Python")

user = User.create email: "tate@oregonstate.edu", name: "John Tate", role: "student"
user.preferences.create course: Course.find_by_name("Python"), value: "disfavor"
user.preferences.create course: Course.find_by_name("Java"), value: "disfavor"
user.preferences.create course: Course.find_by_name("Databases"), value: "favor"
user.skills << Skill.find_by_name("Python")
user.skills << Skill.find_by_name("C++")

user = User.create email: "talkington@oregonstate.edu", name: "Jane Talkington", role: "student"
user.preferences.create course: Course.find_by_name("Python"), value: "disfavor"
user.preferences.create course: Course.find_by_name("Java"), value: "disfavor"
user.preferences.create course: Course.find_by_name("Databases"), value: "favor"
user.skills << Skill.find_by_name("Haskell")
user.skills << Skill.find_by_name("Debugging")

# Instructors
User.create email: "scaffidi@oregonstate.edu", name: "John Scaffidi", role: "instructor"
User.create email: "mcgrath@oregonstate.edu", name: "John McGrath", role: "instructor"
User.create email: "ramsey@oregonstate.edu", name: "John Ramsey", role: "instructor"
User.create email: "jensen@oregonstate.edu", name: "John Jensen", role: "instructor"

# Administrators
User.create email: "tadepalli@oregonstate.edu", name: "John Tadepalli", role: "administrator"
User.create email: "georgej@oregonstate.edu", name: "John George", role: "administrator"

# Student Preferences

# Instructor Preferences

# Student Skills

# Required Skills
