require 'rails_helper'

RSpec.describe MemberVote, :type => :model do
  let(:comm) { build(:committee) }

  it "should be valid with committee, user, vote, and comment" do
    vote = Vote.find(1)
    mv = build(:member_vote)
    mv.vote = vote
    mv.committee = comm
    mv.save
    expect(mv).to be_valid
  end

  it "should have a vote of 'Approved'" do
    approved = build(:approve_vote, committee: comm)
    expect(approved.vote.name).to eq('Approve')
  end

  it "should have a vote of 'Rejected'" do
    rejected = build(:reject_vote, committee: comm)
    expect(rejected.vote.name).to eq('Reject')
  end

end
