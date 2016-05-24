require 'rails_helper'

RSpec.feature "save and submit proposals", :type => :feature do
  let(:proposal) { build(:proposal) }
  let(:user) { create(:user) }

  scenario "User fills out new proposal form and saves a draft" do
    login(user)
    visit new_proposal_path
    within "h1" do
      expect(page).to have_content('Create a new proposal')
    end

    fill_in "Name of proposed project", with: proposal.name
    select "CCCB, CCCB", from: "proposal_lab_group_id"
    fill_in "Objectives", with: proposal.objectives
    fill_in "Background", with: proposal.background
    fill_in "Design details", with: proposal.design_details
  end
end
