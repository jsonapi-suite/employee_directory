require 'faker'

task foo: :environment do
  employees = Employee.where("id > 80 AND id < 100").all

  loop do
    employees.sample
      .update_attribute(:first_name, Faker::Name.first_name)
    employees.sample
      .update_attribute(:last_name, Faker::Name.last_name)
    employees.sample
      .update_attribute(:age, rand(10..100))

    employees.sample.current_position
      .update_attribute(:title, Faker::Lorem.word)

    employees.sample.current_position.department
      .update_attribute(:name, Faker::Lorem.word)
    sleep 0.1
  end
end
