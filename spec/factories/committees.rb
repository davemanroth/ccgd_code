# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :committee do
    proposal { FactoryGirl.build(:proposal) }
    deadline { Faker::Time.forward(14, :morning) }
    faculty [User.find(319), User.find(100)]
    advisors [User.find(310), User.find(110), User.find(319)]

=begin
=end
    factory :three_member do
      after(:build) do |comm|
        2.times do |i|
          comm.member_votes << FactoryGirl.build(
            :member_vote, 
            committee: comm, 
            member_role: 2,
            user: FactoryGirl.create(:faculty)
          )
        end
        comm.member_votes << FactoryGirl.build(
          :member_vote, 
          committee: comm, 
          member_role: 4,
          user: FactoryGirl.create(:advisor)
        )
      end
    end
  end
end
