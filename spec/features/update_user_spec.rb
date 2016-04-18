require 'rails_helper'
require "cancan/matchers"

RSpec.feature 'Update user information', :type=> :feature do
  let(:user) { create(:user) }

  context "Log in as submitter" do
    before(:each) do
      visit root_url
      fill_in 'Username', with: user.username
      fill_in 'Password', with: user.password
      click_on 'Log in'
    end
    
    scenario "User using edit page to update his/her own information" do
=begin
=end
      visit edit_user_path(user)
      expect(page).to have_content('Update any of the fields below')
      fill_in "First name", with: 'Chiwitel'
      fill_in "Last name", with: 'Ejiofor'
      select "Mount Sinai", from: "user_organization_id"
      select "CCCB, CCCB", from: "user_lab_groups"
      click_on 'Update user information'
      user.reload

      within 'h1' do
        expect(page).to have_content user.full_name
      end

      within '.no-list' do
        expect(page).to have_content('Chiwitel Ejiofor')
        expect(page).to have_content('Mount Sinai')
        expect(page).to have_content('CCCB, CCCB')
      end
    end
  end

  context "Log in as admin" do
    let(:many_roles) { create(:many_roles) }
    before(:each) do
      visit root_url
      fill_in 'Username', with: many_roles.username
      fill_in 'Password', with: many_roles.password
      click_on 'Log in'
    end

    scenario "Admin using edit page to remove roles from user" do
      expect(many_roles.roles.size).to eq(5)
      visit edit_user_path(many_roles)
      expect(page).to have_content('Update any of the fields below')

      within '#admin-user-update' do
        expect(find('#user_roles_1')).to be_checked
        expect(find('#user_roles_2')).to be_checked
        expect(find('#user_roles_3')).to be_checked
        expect(find('#user_roles_4')).to be_checked
        expect(find('#user_roles_5')).to be_checked
      end

      within '#admin-user-update' do
        page.uncheck('CCGD Scientific Advisor')
      end
      click_on 'Update user information'
      many_roles.reload

      expect(many_roles.roles.size).to eq(4)

      within '.no-list' do
        expect(page).to have_content('CCGD Submitter, CCGD Administrator, CCGD Faculty, CCGD Lab Staff')
      end
    end

    scenario "Admin using edit page to update status and grant new roles" do
      visit edit_user_path(user)
      expect(page).to have_content('Update any of the fields below')
      within '#admin-user-update' do
        expect(find('#user_status_p')).to be_checked
        expect(find('#user_roles_5')).to be_checked
      end

      within '#admin-user-update' do

        # Make the user active
        choose('user_status_a')

        # Give user Scientific Advisor role
        check('user_roles_4')
      end
      click_on 'Update user information'
      user.reload

      within '.no-list' do
        expect(page).to have_content('Status: Active')
        expect(page).to have_content('CCGD Submitter, CCGD Scientific Advisor')
      end

    end
  end

end
