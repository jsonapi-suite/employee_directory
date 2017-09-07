# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
e = Employee.create!(first_name: 'Homer', last_name: 'Simpson')
e.meetings.create!(duration: 5)
e.meetings.create!(duration: 10)
e.meetings.create!(duration: 15)

e = Employee.create!(first_name: 'Monty', last_name: 'Burns')
e.meetings.create!(duration: 30)
e.meetings.create!(duration: 60)
e.meetings.create!(duration: 90)
