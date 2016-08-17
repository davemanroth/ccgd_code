# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :platform do
    name { Faker::Lorem.words(3).join(' ') }
    code { Faker::Lorem.characters(3).upcase }
  end
end
