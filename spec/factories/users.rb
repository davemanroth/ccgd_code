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
    ccgd_policy 'yes'

    factory :many_roles do
      roles []
      after(:create) do |user|
        (1..4).each do |num|
          user.roles << Role.find(num)
        end
      end
    end

    factory :admin do
      roles []
      after(:create) do |user|
        user.roles << Role.find(1)
      end
    end
  end
end
