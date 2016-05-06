# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_custom_organization do
    association :user
    custom_org_name { Faker::Company.name }
    custom_org_phone { Faker::PhoneNumber.phone_number }
    custom_org_email { Faker::Internet.email }
    custom_street { Faker::Address.street_address }
    custom_city { Faker::Address.city }
    custom_country { Faker::Address.country }
    state_id 1
  end
end
