# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :member_vote do
    association :committee
    user { FactoryGirl.create(:faculty) }
    comment { Faker::Lorem.sentences.join(' ') }

    factory :approve_vote do
      vote Vote.find(1)
    end
=begin

    factory :reject_vote do
      vote Vote.find(2)
    end
=end
  end

end
