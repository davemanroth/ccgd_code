require 'rails_helper'

RSpec.describe User, :type => :model do
  it "is valid with username, firstname, lastname, phone, and email" do
    user = build(:user)
    expect(user).to be_valid
  end

  it "is invalid with a duplicate username" do
    user = create(:user, username: 'davemanroth')
    expect(build(:user, username: 'davemanroth')).to be_invalid
  end

  it "is invalid with a duplicate email address" do
    user = create(:user, email: 'dave@rothfarb.com')
    expect(build(:user, email: 'dave@rothfarb.com')).to be_invalid
  end
end
