require 'rails_helper'

RSpec.feature "Delete a user", :type => :feature do
  let(:admin) { create(:admin) }
  let(:user) { create(:user) }

  scenario "Deletes a user", js: true do
    login(admin)
    visit edit_user_path(user)
    within '#delete-user' do
      click_on 'Delete user'
    end
    within '.modal-content' do
      expect {
        click_on 'Confirm'
      }.to change(User, :count).by(-1)
    end

    expect(user).to be_nil
  end


end
