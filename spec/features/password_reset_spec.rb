require 'rails_helper'

RSpec.feature 'Password reset', :type=> :feature do
  let(:user) { create(:user) }

  before(:each) do
    visit root_url
    click_link('Reset password')
    expect(current_path).to eq(new_password_reset_path)
  end

  scenario "Existing user forgot password and successfully updates it" do

    user.email = 'dave_rothfarb@dfci.harvard.edu'
    user.save
    fill_in "Enter your account email address", with: user.email
    click_on "Reset password"
    expect(current_path).to eq('/')
    expect(page).to have_content("Email sent with password reset information")

    user.reload
    visit edit_password_reset_path(user.password_reset_token, email: user.email)
    expect(page).to have_content("Reset password")
    fill_in "Password", with: "new_password"
    fill_in "Password confirmation", with: "new_password"
    click_on "Update password"

    within '.alert-success' do
      expect(page).to have_content("Password successfully updated")
    end
=begin
=end
  end

  scenario "Existing user forgot password and enters passwords that do not match" do

    user.email = 'dave_rothfarb@dfci.harvard.edu'
    user.save
    fill_in "Enter your account email address", with: user.email
    click_on "Reset password"
    expect(current_path).to eq('/')
    expect(page).to have_content("Email sent with password reset information")

    user.reload

    visit edit_password_reset_path(user.password_reset_token, email: user.email)
    expect(page).to have_content("Reset password")
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "new_password"
    click_on "Update password"
    #binding.pry

    within '.alert-danger' do
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
=begin
=end
  end
end
