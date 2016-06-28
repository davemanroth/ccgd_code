# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :member_vote do
    committee_id 1
    vote_id 1
    user_id 1
    comment "MyText"
  end
end
