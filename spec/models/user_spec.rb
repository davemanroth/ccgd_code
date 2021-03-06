require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { build(:user) }

  it "is valid with username, firstname, lastname, email, phone, password, organization_id, user_id, and status" do
    expect(user).to be_valid
  end

  it "is valid without a phone" do
    user.phone = ''
    expect(user).to be_valid
  end

  it "is invalid without a username" do
    user.username = ''
    user.valid?
    expect(user.errors.messages[:username]).to include("can't be blank")
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

=begin
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
=end

  it "belongs to the Organization  model" do
    expect(user).to belong_to(:organization)
  end

  it "can have many memberships" do
    expect(user).to have_many(:memberships)
  end

  it "has 1 labgroup" do
    user.save
    lg = FactoryGirl.build(:lab_group)
    user.lab_groups << lg
    expect(user.lab_groups.count).to eq 1
  end

  it "can have many privileges" do
    expect(user).to have_many(:privileges)
  end

  it "has 2 roles" do
    user.save
    [:role, :role].each do |role|
      user.roles << FactoryGirl.create(:role)
    end
    expect(user.roles.count).to eq 3
  end

  it "has a status of pending when first created" do
    user.save
    expect(user.status).to eq 'P'
  end

  it "has a status of pending when using the pending scope" do
    users = User.pending
    expect(users.first.status).to eq 'P'
  end

  it "outputs custom organization fields hash" do
    cf_user = create(:custom_fields_user)
    expect(cf_user.org_attributes).to be_an_instance_of(Hash)
  end

  it "outputs custom labgroup fields hash" do
    cf_user = create(:custom_fields_user)
    expect(cf_user.lab_attributes).to be_an_instance_of(Hash)
  end

  it "shows all lab groups of a particular user" do
    labgroup = LabGroup.find(1)
    user.lab_groups << labgroup
    user.save
    expect(user.all_lab_groups.first).to eq 'CCGD Administration'
  end

  it "has a status of approved when using the approved scope" do
    users = User.approved
    expect(users.first.status).to eq 'A'
  end

  it "generates a password reset token" do
    user.generate_token(:password_reset_token)
    user.save
    expect(user.password_reset_token).to be_a(String)
  end

end
