# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :proposal do
    association :user
    name { Faker::Company.name }
    objectives { Faker::Lorem.sentences }.join('. ')
    objectives { Faker::Lorem.sentences }.join('. ')
    objectives { Faker::Lorem.sentences }.join('. ')
    objectives { Faker::Lorem.sentences }.join('. ')
    objectives { Faker::Lorem.sentences }.join('. ')
    objectives { Faker::Lorem.sentences }.join('. ')
    financial_contact { Faker::Name.name }
    billing_dept { Faker::Commerce.department }
    billing_street { Faker::Address.street_address }
    billing_building { Faker::Address.building_number }
    billing_room { Faker::Address.building_number }
    billing_city { Faker::Address.city }
    billing_zip { Faker::Address.zip }
    billing_email { Faker::Internet.email }
    billing_phone { Faker::PhoneNumber.phone_number }
    state_id 1
  end
end
