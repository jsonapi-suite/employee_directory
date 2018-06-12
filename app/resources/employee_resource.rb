class EmployeeResource < ApplicationResource
  attribute :first_name, :string
  attribute :last_name, :string
  attribute :age, :integer
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false

  has_many :positions
  has_one :current_position, resource: PositionResource do
    params do |hash|
      hash[:filter][:current] = true
    end
  end

  sort :name, :string do |scope, dir|
    scope.order(last_name: dir)
  end

  sort :title, :string do |scope, dir|
    scope.joins(:current_position).merge(Position.order(title: dir))
  end

  sort :department_name, :string do |scope, dir|
    scope.joins(current_position: :department)
      .merge(Department.order(name: dir))
  end
end
