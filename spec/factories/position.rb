FactoryGirl.define do
  factory :position do
    department
    title { Faker::Lorem.word }
  end
end
