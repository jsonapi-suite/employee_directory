class Department < ApplicationRecord
  has_many :positions
  has_many :rooms
  has_many :employees
end
