class Employee < ApplicationRecord
  has_many :positions
  has_many :meetings
  validates :first_name, presence: true

  has_one_attached :profile_photo

  scope :with_meeting_duration, -> {
    columns = Employee.column_names.map { |n| "employees.#{n}" }
    group("employees.id")
      .joins("left outer join meetings on meetings.employee_id = employees.id")
      .select("#{columns.join(',')}, sum(meetings.duration) as meeting_duration")
  }
end
