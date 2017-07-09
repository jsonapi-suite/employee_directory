class Position < ApplicationRecord
  belongs_to :employee, optional: true
  belongs_to :department, optional: true

  searchkick text_start: [:title]
end
