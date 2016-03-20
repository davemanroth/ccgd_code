# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    building { Faker::Company.name }
    room { Faker::Address.building_number }
    address_id 12
  end
end
