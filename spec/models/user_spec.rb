require 'rails_helper'

RSpec.describe User, :type => :model do
  it "is valid with username, firstname, lastname, phone, and email"
  it "is invalid with a duplicate email address"
end
