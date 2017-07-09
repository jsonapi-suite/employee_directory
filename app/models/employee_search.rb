class EmployeeSearch < Trample::Search
  model Employee

  condition :first_name, single: true
  condition :last_name, single: true
end
