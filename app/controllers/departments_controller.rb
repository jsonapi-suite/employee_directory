class DepartmentsController < ApplicationController
  def index
    departments = DepartmentResource.all(params)
    respond_with departments
  end
end
