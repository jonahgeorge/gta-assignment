class Skill < ActiveRecord::Base
  self.inheritance_column = :_type_disabled

  enum type: {
    :"Hard skill"     => 0,
    :"Lab experience" => 1
  }

  validates_presence_of :type
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :experiences, dependent: :destroy
end
