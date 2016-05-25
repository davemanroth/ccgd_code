require 'rails_helper'

RSpec.feature "save and submit proposals", :type => :feature do
  let(:proposal) { build(:proposal) }
  let(:user) { create(:user) }

  before(:each) do
    default_url_options[:host] = 'http://ccgd.hccdev.org'
  end

  scenario "User fills out new proposal form and saves a draft" do
    login(user)
    visit new_proposal_path

    within "h1" do
      expect(page).to have_content('Create a new proposal')
    end

    expect {
      fill_in "Name of proposed project", with: proposal.name
      select "CCCB, CCCB", from: "proposal_lab_group_id"
      select "Affymetrix SNP Array", from: "proposal_platforms"
      fill_in "Objectives", with: proposal.objectives
      fill_in "Background", with: proposal.background
      fill_in "Design details", with: proposal.design_details
      fill_in "Sample availability", with: proposal.sample_availability
      fill_in "Contributions", with: proposal.contributions
      fill_in "Comments", with: proposal.comments
      fill_in "Financial contact", with: proposal.financial_contact
      fill_in "Billing department", with: proposal.billing_dept
      fill_in "Billing street", with: proposal.billing_street
      fill_in "Billing building", with: proposal.billing_building
      fill_in "Billing room", with: proposal.billing_room
      fill_in "Billing city", with: proposal.billing_city
      fill_in "Billing zip", with: proposal.billing_zip
      fill_in "Billing email", with: proposal.billing_email
      fill_in "Billing phone", with: proposal.billing_phone
      select "MA", from: "proposal_state_id"
      check('proposal_ccgd_policy')
      click_on 'Save proposal'
    }.to change(Proposal, :count).by(+1)

    expect(page.current_path).to be(['users/', user.id].join())

=begin
    within ".proposal-info" do
      expect(page).to have_content('Proposals')
      expect(page).to have_content(proposal.name)
    end
=end
  end
end
