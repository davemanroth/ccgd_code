require 'rails_helper'

RSpec.feature "Admin add org and labgroups", :type => :feature do
  let(:admin) { create(:admin) }
  let(:cf_user) { create(:custom_fields_user) }
  before :each do
    login(admin)
    visit edit_user_path(cf_user)
  end

  scenario "Admin adds an organization based on user's custom fields" do
    within '#labs_and_orgs' do
      expect {
        find('#org').click_on 'Add'
      }.to change(Organization, :count).by(+1)
    end
    cf_user.reload
    expect(cf_user.user_custom_organization).to be_nil
    expect(cf_user.organization).not_to be_nil
  end

  scenario "Admin adds a labgroup based on user's custom fields" do
    within '#labs_and_orgs' do
      expect {
        find('#lab').click_on 'Add'
      }.to change(LabGroup, :count).by(+1)
    end
    cf_user.reload
    expect(cf_user.user_custom_labgroup).to be_nil
    expect(cf_user.lab_groups.count).to be > 0
  end

  scenario "Admin deletes an organization based on user's custom fields" do
    within '#labs_and_orgs' do
      expect {
        find('#org').click_on 'Delete'
      }.to change(LabGroup, :count).by(-1)
    end
    cf_user.reload
    # expect(cf_user.user_custom_labgroup).to be_nil
    expect(cf_user.lab_groups.count).to be 0
  end

end
