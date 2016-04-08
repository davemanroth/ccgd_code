require 'rails_helper'

RSpec.feature 'Update user status', :type=> :feature do
  let(:user) { create(:user) }

  scenario "updates pending to active" do
    visit users_path
    within '#users' do

    end

  end
end
