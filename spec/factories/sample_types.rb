# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sample_type do
    name { Faker::Lorem.word }
  end
end
