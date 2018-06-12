class Position < ApplicationRecord
  belongs_to :employee, optional: true
  belongs_to :department

  validates :title, presence: true

  scope :current, ->(bool = true) {
    clause = { historical_index: 1 }
    bool ? where(clause) : where.not(clause)
  }
end
