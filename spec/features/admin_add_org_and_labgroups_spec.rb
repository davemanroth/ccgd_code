require 'rails_helper'

RSpec.feature "Admin add org and labgroups", :type => :feature do
  let(:admin) { create(:admin) }
  before :each do
    login(admin)
  end

  scenario "Admin adds an organization based on user's custom fields" do
    cf_user = create(:custom_fields_user)
    pp cf_user.user_custom_organization
  end
end
