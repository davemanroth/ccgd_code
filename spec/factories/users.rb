# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    firstname "MyString"
    lastname "MyString"
    email "MyString"
    phone "MyString"
  end
end
