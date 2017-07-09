class Employee < ApplicationRecord
  has_many :positions
  validates :first_name, presence: true

  searchkick text_start: [:first_name]
end
