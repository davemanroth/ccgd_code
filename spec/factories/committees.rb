# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :committee do
    proposal { FactoryGirl.build(:proposal) }
    deadline { Faker::Time.forward(14, :morning) }

=begin
=end
    after(:build) do |comm|
      3.times do |i|
        comm.committee_members << FactoryGirl.build(:committee_member)
      end
    end
  end
end
