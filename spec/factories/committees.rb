# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :committee do
    proposal { FactoryGirl.build(:proposal) }
    deadline { Faker::Time.forward(14, :morning) }

=begin
=end
    factory :three_member do
      after(:build) do |comm|
        3.times do |i|
          comm.member_votes << FactoryGirl.build(:member_vote, committee: comm, vote: Vote.find(i + 1))
        end
      end
    end
  end
end
