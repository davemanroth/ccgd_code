require 'rails_helper'

RSpec.feature 'Update user information', :type=> :feature do
  let(:user) { create(:user) }

  scenario "User using edit page to update his/her own information" do
    visit edit_user_path(user)
    expect(page).to have_content('Update any of the fields below')
    fill_in "First name", with: 'Chiwitel'
    fill_in "Last name", with: 'Ejiofor'
    select "Mayer, 630", from: "user_location_id"
    select "Mount Sinai", from: "user_organization_id"
    select "CCCB, CCCB", from: "user_lab_groups"
    click_on 'Update user information'
    user.reload

    within 'h1' do
      expect(page).to have_content user.full_name
    end

    within '.no-list' do
      expect(page).to have_content('Chiwitel Ejiofor')
      expect(page).to have_content('Mayer, 630')
      expect(page).to have_content('Mount Sinai')
      expect(page).to have_content('CCCB, CCCB')
    end
  end

  scenario "Admin using edit page for admin features" do
    visit edit_user_path(user)
    expect(page).to have_content('Update any of the fields below')
    within '#admin-user-update' do
      expect(find('#user_status_p')).to be_checked
      expect(find('#user_roles_5')).to be_checked
    end

    within '#admin-user-update' do
      choose('user_status_a')
      check('user_roles_4')
    end
    click_on 'Update user information'
    user.reload

    within '.no-list' do
      expect(page).to have_content('Status: Active')
      expect(page).to have_content('Role(s): CCGD Submitter, CCGD Scientific Advisor')
    end

  end

end
