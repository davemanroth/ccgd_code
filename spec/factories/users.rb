# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    password 'password'
    password_confirmation 'password'
    organization_id 1
    location_id 1
    status "A"

    after(:create) do |user|
      [:role, :role].each do |role|
        user.roles << create(role)
      end
    end
  end
end
