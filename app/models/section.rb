class Section < ActiveRecord::Base
  default_scope { order(term: :asc, number: :asc) }

  belongs_to :course
end
