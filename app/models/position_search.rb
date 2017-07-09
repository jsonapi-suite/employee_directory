class PositionSearch < Trample::Search
  model Position

  condition :title, single: true
  condition :employee_id
end
