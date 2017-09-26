class DepartmentResource < ApplicationResource
  type :departments
  model Department

  has_many :rooms,
    foreign_key: :department_id,
    resource: RoomResource,
    scope: -> { Room.all }
  has_many :employees,
    foreign_key: :department_id,
    resource: EmployeeResource,
    scope: -> { Employee.all }
end
