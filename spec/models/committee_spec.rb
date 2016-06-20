require 'rails_helper'

RSpec.describe Committee, :type => :model do
  let(:comm) { build(:committee) }

  it "is valid with proposal id, deadline, and committee members" do
    expect(comm).to be_valid
  end

  it "is not valid without a proposal id"
  it "is not valid without a deadline"
  it "is not valid without any committee members"
end
