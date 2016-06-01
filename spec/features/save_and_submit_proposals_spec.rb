require 'rails_helper'

RSpec.feature "save and submit proposals", :type => :feature do
  let(:proposal) { build(:proposal) }
  let(:user) { create(:user) }

=begin
=end
  before(:each) do
    default_url_options[:host] = 'http://ccgd.hccdev.org'
    login(user)
    click_on 'Submit a new proposal'
  end

  scenario "User fills out new proposal form and saves a draft" do

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
      click_on 'Save draft'
    }.to change(Proposal, :count).by(+1)

    expect(page.current_path).to eq(['/users/', user.id].join())
    expect(page).to have_content('Proposals')

    within ".draft-proposals" do
      expect(page).to have_content(proposal.name)
    end
  end

  scenario "User fills out new proposal form and submits the proposal" do

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
      click_on 'Submit proposal'
    }.to change(Proposal, :count).by(+1)

    expect(page.current_path).to eq(['/users/', user.id].join())
    expect(page).to have_content('Proposals')

    within ".submitted-proposals" do
      expect(page).to have_content(proposal.name)
    end
  end
end
