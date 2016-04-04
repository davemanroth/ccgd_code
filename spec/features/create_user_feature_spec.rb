require 'rails_helper'

RSpec.feature 'User creation', :type=> :feature do

  scenario "visits the create user page and creates user" do

    visit signup_path

    within 'h1' do
      expect(page).to have_content('Create a CCGD user account')
    end

    # Verify location, organization, and labgroup select lists display correctly
    within "#select-lists" do
      expect(page).to have_select "user_location_id", with_options: ['020, 0G4']
      expect(page).to have_select "user_organization_id", with_options: ['Beckman Coulter']
      expect(page).to have_select "user_lab_groups", with_options: ['15th floor, Meyerson']
    end

    fields = {
      firstname: 'Dave',
      lastname: 'Rothfarb',
      email: 'dave@rothfarb.com',
      phone: '555-555-5555',
      username: 'davemanroth',
      password: 'password',
      organization: 1,
      location: 1,
      lab_group: 24
    }

    # Enter all user data and click submit
    expect {
      fill_in "First name", with: fields[:firstname]
      fill_in "Last name", with: fields[:lastname]
      fill_in "Email", with: fields[:email]
      fill_in "Phone", with: fields[:phone]
      fill_in "Username", with: fields[:username]
      fill_in "Password", with: fields[:password]
      fill_in "Password confirmation", with: fields[:password]
      select "020, 0G4", from: "user_location_id"
      select "Beckman Coulter", from: "user_organization_id"
      select "15th floor, Meyerson", from: "user_lab_groups"
      click_on 'Create user account'
    }.to change(User, :count).by(+1)

    # Verify submitted location, organization, and labgroup display correctly
    within '.no-list' do
      expect(page).to have_content '020, 0G4'
      expect(page).to have_content 'Beckman Coulter'
      expect(page).to have_content '15th floor, Meyerson'
    end
=begin
=end
  end
end
