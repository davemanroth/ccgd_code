require 'rails_helper'

RSpec.describe Proposal, :type => :model do
  let(:prop) { build(:proposal) }

  it "should be valid with all fields entered" do
    expect(prop).to be_valid
  end

  it "should be invalid without a user id" do
    prop.user_id = nil
    expect(prop).to be_invalid
  end

  it "should have a name" do
    expect(prop.name).to be_a(String)
  end

  it "should have objectives" do
    expect(prop.objectives).to be_a(String)
  end

  it "should have a status" do
    status = ProposalStatus.find(1)
    prop.proposal_status = status
    expect(prop.proposal_status.code).to eq('draft')
  end

=begin
# This will be implemented after admin approves submission
  it "should have 3 total platforms and the correct code" do
    pl = Platform.find(3)
    prop.platforms << pl
    prop.save
    id = 1000 + prop.id
    expect(prop.platforms.count).to eq(3)
    expect(prop.code).to eq(['SGT', id].join(''))
  end
=end
end
