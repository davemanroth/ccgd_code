# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :committee_member do
    association :committee
    comment { Faker::Lorem.sentences(2).split(' ') }

    after(:build) do |cm|
      cm.user << FactoryGirl.build(:faculty)
    end
  end
end
