require 'rails_helper'

RSpec.feature "save and submit proposals", :type => :feature do
  let(:proposal) { build(:proposal) }
  let(:user) { create(:user) }

=begin
=end
  before(:each) do
    #default_url_options[:host] = 'http://localhost:3000'
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

  scenario "User fills out new proposal form, submits the proposal but does not agree to ccgd policy terms" do
  
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
    }.to change(Proposal, :count).by(0)

    expect(page).to have_css('#errors-list')

    within '#errors-list' do
      expect(page).to have_content "You must accept the CCGD policy"
    end
    expect(page.current_path).to eq('/proposals')

  end

=begin
This is commented out because I first need to get JavaScript working properly to get the proposal submission working
  scenario "User fills out new proposal form, accepts the ccgd policy terms, and submits the proposal" do
    visit root_path
    fill_in "Username", with: "rothfarb-test"
    fill_in "Password", with: "B0ll0ck5!"
    click_on "Log in"
    click_on "Submit a new proposal"

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
      click_on 'Accept CCGD policy'
      click_on 'Accept terms'
      click_on 'Submit proposal'
    }.to change(Proposal, :count).by(+1)

    expect(page).to have_content('Proposals')

    within ".submitted-proposals" do
      expect(page).to have_content(proposal.name)
    end
  end
=end

end
