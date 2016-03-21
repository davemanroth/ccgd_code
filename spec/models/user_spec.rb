require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { build(:user) }

  it "is valid with username, firstname, lastname, email, phone, password, prganization_id, user_id, and status" do
    expect(user).to be_valid
  end

  it "is valid without a phone" do
    user.phone = ''
    expect(user).to be_valid
  end

  it "is invalid without a username" do
    user.username = ''
    expect(user).to be_invalid
  end

  it "is invalid without a password" do
    user.password = ''
    user.password_confirmation = ''
    expect(user).to be_invalid
  end

  it "is invalid with passwords that do not match" do
    user.password = 'password'
    user.password_confirmation = 'foobar'
    expect(user).to be_invalid
  end

  it "is invalid without a first name" do
    user.firstname = ''
    expect(user).to be_invalid
  end

  it "is invalid without a last name" do
    user.lastname = ''
    expect(user).to be_invalid
  end

  it "is invalid without an email" do
    user.email = ''
    expect(user).to be_invalid
  end

  it "is invalid with duplicate emails" do
    user.email = 'dave@rothfarb.com'
    user.save
    user2 = build(:user)
    user2.email = 'dave@rothfarb.com'
    expect(user2).to be_invalid
  end

  it "is invalid without an organization_id" do
    user.organization_id = ''
    expect(user).to be_invalid
  end

  it "is invalid without an location_id" do
    user.location_id = ''
    expect(user).to be_invalid
  end

  /
  it "belongs to the Address model" do
    expect(user).to belong_to(:address)
  end

  it "is associated with many lab_groups" do
    expect(user).to have_many(:lab_groups)
  end
/

end
