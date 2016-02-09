class Term < ActiveRecord::Base
  enum season: { winter: 0, spring: 1, summer: 2, fall: 3 }

  has_and_belongs_to_many :sections
end
