class EmployeeResource < ApplicationResource
  use_adapter ElasticsearchAdapter
  type :employees
  model Employee

  allow_filter :first_name

  has_many :positions,
    scope: -> { PositionSearch.new },
    resource: PositionResource,
    foreign_key: :employee_id
end
