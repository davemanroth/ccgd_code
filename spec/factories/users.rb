# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    phone { Faker::PhoneNumber.phone_number }
    password 'password'
    password_confirmation 'password'
  end
end
