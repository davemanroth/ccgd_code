require 'rails_helper'

RSpec.describe Organization, :type => :model do
  let(:org) { build(:organization) }

  it "is valid with a name, phone number, email, and org" do
    expect(org).to be_valid
  end

  it "is valid without a phone" do
    org.phone = ''
    expect(org).to be_valid
  end

  it "is valid without an email" do
    org.email = ''
    expect(org).to be_valid
  end

  it "is invalid without a name" do
    org.name = ''
    expect(org).to be_invalid
  end

  it "is invalid without an address" do
    org.address_id = ''
    expect(org).to be_invalid
  end

  it "belongs to the Address model" do
    expect(org).to belong_to(:address)
  end

end
