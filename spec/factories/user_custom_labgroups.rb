# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_custom_labgroup do
    association :user
    custom_labgroup_name { Faker::Company.name }
    custom_labgroup_code { Faker::Company.suffix }
    custom_labgroup_building { Faker::Lorem.word }
    custom_labgroup_room { Faker::Address.building_number }
    custom_labgroup_street { Faker::Address.street_address }
    custom_labgroup_city { Faker::Address.city }
    custom_labgroup_country { Faker::Address.country }
    state_id 1
  end
end
