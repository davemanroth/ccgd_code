require 'rails_helper'

RSpec.describe Address, :type => :model do
  let(:address) { build(:address) }

  it "is valid with a street, city, and country" do
    expect(address).to be_valid
  end

  it "is valid without a state" do
    address.state_id = ''
    expect(address).to be_valid
  end

  it "is valid without a country" do
    address.country = ''
    expect(address).to be_valid
  end

  it "is invalid without a street" do
    address.street = ''
    expect(address).to be_invalid
  end

  it "is invalid without a city" do
    address.city = ''
    expect(address).to be_invalid
  end

  it "belongs to the State model" do
    expect(address).to belong_to(:state)
  end

  it "is associated with many organizations" do
    expect(address).to have_many(:organizations)
  end

  it "has one associated location" do
    expect(address).to have_one(:location)
  end
end
