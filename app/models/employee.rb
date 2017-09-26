class Employee < ApplicationRecord
  belongs_to :department
  has_many :positions
  validates :first_name, presence: true

  has_one_attached :profile_photo
end
