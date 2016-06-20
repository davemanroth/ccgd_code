# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    association :committee_member
    username { Faker::Internet.user_name }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    password 'password'
    password_confirmation 'password'
    organization_id 1

    factory :many_roles do
      after(:create) do |user|
        (1..4).each do |num|
          user.roles << Role.find(num)
        end
      end
    end

    factory :admin do
      after(:create) do |user|
        user.roles << Role.find(1)
      end
    end

    factory :faculty do
      after(:create) do |user|
        user.roles << Role.find(2)
      end
    end

    factory :custom_fields_user do
      after(:create) do |user|
        user.organization_id = nil
        user.user_custom_organization = FactoryGirl.build(:user_custom_organization, user: user)
        user.user_custom_labgroup = FactoryGirl.build(:user_custom_labgroup, user: user)
      end
    end
  end
end
