# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :privilege do
    /
    role_id 1
    user_id 1
    /
    association :user
    association :role
  end
end
