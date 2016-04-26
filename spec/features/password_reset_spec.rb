require 'rails_helper'

RSpec.feature 'Password reset', :type=> :feature do
  let(:user) { build(:user) }

  scenario "Existing user forgot password and successfully updates it" do
    visit root_url
    click_link('Reset password')
    expect(current_path).to eq(new_password_resets_path)

    user.email = 'dave_rothfarb@dfci.harvard.edu'
    user.save
    fill_in "Enter your email", with: user.email
    click_on "Reset password"
    expect(current_path).to eq('/')
    expect(page).to have_content("Email sent with password reset information")
  end
end
