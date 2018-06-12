FactoryGirl.define do
  factory :position do
    employee
    department

    title { Faker::Lorem.word }
  end
end
