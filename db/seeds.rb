[Employee, Position].each(&:delete_all)
bart = Employee.create!(first_name: 'Bart', last_name: 'Simpson')
homer = Employee.create!(first_name: 'Homer', last_name: 'Simpson')
monty = Employee.create!(first_name: 'Monty', last_name: 'Burns')

bart.positions.create!(title: 'Junior Engineer')
homer.positions.create!(title: 'Senior Engineer')
monty.positions.create!(title: 'Manager')
