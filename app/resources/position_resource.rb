class PositionResource < ApplicationResource
  attribute :employee_id, :integer, only: [:writable, :filterable]
  attribute :department_id, :integer, only: [:writable]

  attribute :title, :string

  belongs_to :employee
  belongs_to :department

  filter :current, :boolean do
    eq do |scope, value|
      value.each do |v|
        scope = scope.current(v)
      end
      scope
    end
  end
end
