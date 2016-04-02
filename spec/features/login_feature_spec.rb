require 'rails_helper'

RSpec.feature 'Authentication', :type=> :feature do
  let(:user) { create(:user) }

  scenario "signs in with correct credentials and redirected to user page" do
    visit root_url
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_on 'Log in'
    expect(current_path).to eq([users_path, user.id].join('/'))

    within 'h1' do
      expect(page).to have_content user.full_name
    end
  end
end
