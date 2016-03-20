# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lab_group do
    name { Faker::Company.name }
    code { Faker::Hacker.abbreviation }
    location_id 1
  end
end
