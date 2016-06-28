require 'rails_helper'

RSpec.describe Committee, :type => :model do
  let(:comm) { build(:committee) }

  it "is valid with proposal id and deadline" do
    expect(comm).to be_valid
  end

  it "is not valid without a proposal" do
    comm.proposal = nil
    expect(comm).to be_invalid
  end

  it "is not valid without a deadline" do
    comm.deadline = nil
    expect(comm).to be_invalid
  end

  it "has 3 member votes" do
    three_member = create(:three_member)
    expect(three_member.member_votes.count).to eq(3)
  end
end
