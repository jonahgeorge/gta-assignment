class Skill < ActiveRecord::Base
  # has_and_belongs_to_many :courses
  # has_and_belongs_to_many :students

  validates_presence_of :name
end
