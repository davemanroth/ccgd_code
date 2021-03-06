require 'rails_helper'

RSpec.feature 'User creation', :type=> :feature do


  before :each do
    visit signup_path

    within 'h1' do
      expect(page).to have_content('Create a CCGD user account')
    end

    # Verify location, organization, and labgroup select lists display correctly
    within "#select-lists" do
      expect(page).to have_select "user_organization_id", with_options: ['Beckman Coulter']
      expect(page).to have_select "user_lab_groups", with_options: ['15th floor, Meyerson']
    end
  end

  scenario "goes to create user page, fills out all fields correctly" do
    # Enter all user data and click submit
    expect {
      fill_in "First name", with: 'Dave'
      fill_in "Last name", with: 'Rothfarb'
      fill_in "Email", with: 'dave@rothfarb.com'
      fill_in "Phone", with: '555-555-5555'
      fill_in "Username", with: 'davemanroth-test'
      fill_in "Password", with: 'password'
      fill_in "Password confirmation", with: 'password'
      select "Beckman Coulter", from: "user_organization_id"
      select "15th floor, Meyerson", from: "user_lab_groups"
      select "Beckman, Beckman", from: "user_lab_groups"
      click_on 'Create user account'
    }.to change(User, :count).by(+1)

=begin
=end
  end

  scenario "goes to create user page, but omits fields" do
    # Enter all user data and click submit
    expect {
      fill_in "Last name", with: 'Rothfarb'
      fill_in "Email", with: 'dave@rothfarb.com'
      fill_in "Phone", with: '555-555-5555'
      fill_in "Username", with: 'davemanroth-test'
      fill_in "Password", with: 'password'
      fill_in "Password confirmation", with: 'password'
      select "Beckman Coulter", from: "user_organization_id"
      select "15th floor, Meyerson", from: "user_lab_groups"
      select "Beckman, Beckman", from: "user_lab_groups"
      click_on 'Create user account'
    }.to change(User, :count).by(0)

    # expect(page).to have_current_path(new_user_path)
    expect(page).to have_css('#errors-list')

    within '#errors-list' do
      expect(page).to have_content "Firstname can't be blank"
    end
  end

=begin
=end
  scenario "goes to create user page, fills in custom labgroup/org fields instead of using preselect values" do
    expect {
      fill_in "First name", with: 'Dave'
      fill_in "Last name", with: 'Rothfarb'
      fill_in "Email", with: 'dave@rothfarb.com'
      fill_in "Phone", with: '555-555-5555'
      fill_in "Username", with: 'davemanroth-test'
      fill_in "Password", with: 'password'
      fill_in "Password confirmation", with: 'password'
      click_on('Add a new organization')
      fill_in "Organization name", with: 'Test organization'
      click_on('Add a new Lab/group')
      fill_in "Lab/group name", with: 'Test lab'
      click_on 'Create user account'
    }.to change(User, :count).by(1)

    user = User.find_by(username: 'davemanroth-test')
    expect(user.user_custom_organization.custom_org_name).to eq('Test organization')
    expect(user.user_custom_labgroup.custom_labgroup_name).to eq('Test lab')

  end

end
