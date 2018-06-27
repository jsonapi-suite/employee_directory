class PositionResource < ApplicationResource
  type :positions
  model Position

  allow_filter :title_prefix do |scope, value|
    scope.where(["title LIKE ?", "#{value}%"])
  end

  has_many :employees,
    resource: EmployeeResource,
    foreign_key: :position_id,
    scope: -> { Employee.all }

  belongs_to :department,
    scope: -> { Department.all },
    foreign_key: :department_id,
    resource: DepartmentResource
end
