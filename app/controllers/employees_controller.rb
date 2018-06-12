class EmployeesController < ApplicationController
  def index
    employees = EmployeeResource.all(params)
    respond_with employees
  end

  def show
    employee = EmployeeResource.find(params)
    respond_with employee
  end

  def create
    employee = EmployeeResource.build(params)

    if employee.save
      respond_with employee
    else
      render jsonapi_errors: employee
    end
  end

  def update
    employee = EmployeeResource.find(params)

    if employee.update_attributes
      respond_with employee
    else
      render jsonapi_errors: employee
    end
  end

  def destroy
    employee = EmployeeResource.find(params)

    if employee.destroy
      respond_with employee
    else
      render jsonapi_errors: employee
    end
  end
end
