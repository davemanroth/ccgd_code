# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :proposal do
    association :user
    name { Faker::Company.name }
    objectives { Faker::Lorem.sentences.join(' ') }
    background { Faker::Lorem.sentences.join(' ') }
    design_details { Faker::Lorem.sentences.join(' ') }
    sample_availability { Faker::Lorem.sentences.join(' ') }
    contributions { Faker::Lorem.sentences.join(' ') }
    comments { Faker::Lorem.sentences.join(' ') }
    proposal_status_id 1
    lab_group_id 27
    sample_types [SampleType.find(1)]
    platforms [Platform.new, Platform.new]

    after(:build) do |prop|
      prop.user = FactoryGirl.create(:user)
    end

  end
end
