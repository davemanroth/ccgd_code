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

  it "should have a platform" do
    platform = Platform.find(1)
    prop.platform = platform
    expect(prop.platform.code).to eq('GT')
  end

  it "should not be submitted" do
    expect(prop.submitted?).to be(false)
  end

  it "should have the proper code" do
    prop.save
    id = 1000 + prop.id
    expect(prop.code).to eq(['SGT', id].join(''))
  end

end
