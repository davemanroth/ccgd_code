require 'rails_helper'

RSpec.describe LabGroup, :type => :model do
  let(:labgroup) { build(:lab_group) }

  it "is valid with a name, code, and location_id" do
    expect(labgroup).to be_valid
  end

  it "is invalid without a name" do
    labgroup.name = ''
    expect(labgroup).to be_invalid
  end

  it "is invalid without a code" do
    labgroup.code = ''
    expect(labgroup).to be_invalid
  end

  it "is invalid without a location_id" do
    labgroup.location_id = ''
    expect(labgroup).to be_invalid
  end

  it "belongs to the Location model" do
    expect(labgroup).to belong_to(:location)
  end

end
