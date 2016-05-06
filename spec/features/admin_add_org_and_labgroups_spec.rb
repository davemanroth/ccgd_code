require 'rails_helper'

RSpec.feature "Admin add org and labgroups", :type => :feature do
  let(:admin) { create(:admin) }
  let(:cf_user) { create(:custom_fields_user) }
  before :each do
    login(admin)
  end

  scenario "Admin adds an organization based on user's custom fields" do
    visit edit_user_path(cf_user)
    within '#labs_and_orgs' do
      expect {
        find('#org').click_on 'Add'
      }.to change(Organization, :count).by(+1)
    end
  end

  scenario "Admin adds a labgroup based on user's custom fields" do
    visit edit_user_path(cf_user)
    within '#labs_and_orgs' do
      expect {
        find('#lab').click_on 'Add'
      }.to change(LabGroup, :count).by(+1)
    end
  end
end
