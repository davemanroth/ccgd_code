# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization do
    name { Faker::Company.name }
    phone { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
    address_id 1
  end
end
