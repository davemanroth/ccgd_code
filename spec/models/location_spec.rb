require 'rails_helper'

RSpec.describe Location, :type => :model do
  let(:location) { build(:location) }

  it "is valid with a building and room" do
    expect(location).to be_valid
  end

  it "is valid without a room" do
    location.room = ''
    expect(location).to be_valid
  end

  it "is invalid without an address" do
    location.address_id = ''
    expect(location).to be_invalid
  end

  it "is invalid without a building" do
    location.building = ''
    expect(location).to be_invalid
  end

  it "belongs to the Address model" do
    expect(location).to belong_to(:address)
  end

  it "is associated with many lab_groups" do
    expect(location).to have_many(:lab_groups)
  end

end
