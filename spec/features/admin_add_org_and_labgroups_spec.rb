require 'rails_helper'

RSpec.feature "Admin add org and labgroups", :type => :feature do
  let(:admin) { create(:admin) }
  before :each do
    login(admin)
  end

  scenario "Admin adds an organization based on user's custom fields" do
    cf_user = create(:custom_fields_user)
    visit edit_user_path(cf_user)
    within '#labs_and_orgs' do
      expect {
        click_on 'Add organization'
      }.to change(Organization, :count).by(+1)
    end
  end
end
