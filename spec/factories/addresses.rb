# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    street Faker::Address.street_address
    city Faker::Address.city
    country Faker::Address.country
  end
end
