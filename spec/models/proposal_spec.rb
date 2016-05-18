require 'rails_helper'

RSpec.describe Proposal, :type => :model do
  let(:prop) { build(:proposal) }

  it "should be valid with all fields entered" do
    expect(prop).to be_valid
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

  it "should have 2 platforms" do
    pl1 = Platform.find(1)
    pl2 = Platform.find(2)
    [pl1, pl2].each do |pl|
      prop.platforms << pl
    end
    prop.save
    expect(prop.platforms.count).to eq(2)
  end

  it "should not be submitted" do
    expect(prop.submitted?).to be(false)
  end

  it "should have the proper code" do
    pp prop.id
    id = 1000 + prop.id
    expect(prop.code).to eq(['SGT', id].join(''))
  end

end
