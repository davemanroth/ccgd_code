require 'rails_helper'

RSpec.feature "Saving, editing, and submitting proposals", :type => :feature do
  let(:proposal) { build(:proposal) }
  let(:user) { create(:user) }

=begin
=end
  before(:each) do
    #default_url_options[:host] = 'http://localhost:3000'
    #default_url_options[:host] = 'http://ccgd.hccdev.org'
    login(user)
  end

  scenario "User fills out new proposal form and saves a draft" do
    click_on 'Submit a new proposal'

    within "h1" do
      expect(page).to have_content('Create a new proposal')
    end

    expect {
      fill_in "Name of proposed project", with: proposal.name
      select "CCCB, CCCB", from: "proposal_lab_group_id"
      select "Affymetrix SNP Array", from: "proposal_platforms"
      select "RNA", from: "proposal_sample_types"
      fill_in "Objectives", with: proposal.objectives
      fill_in "Background", with: proposal.background
      fill_in "Design details", with: proposal.design_details
      fill_in "Sample availability", with: proposal.sample_availability
      fill_in "Contributions", with: proposal.contributions
      fill_in "Comments", with: proposal.comments
      click_on "Save draft"
    }.to change(Proposal, :count).by(+1)

    expect(page.current_path).to eq(['/users/', user.id].join())
    expect(page).to have_content('Proposals')

    within ".draft-proposals" do
      expect(page).to have_content(proposal.name)
    end

  end

  scenario "User fills out new proposal form and adds a new sample type" do
    click_on 'Submit a new proposal'

    within "h1" do
      expect(page).to have_content('Create a new proposal')
    end

    expect {
      fill_in "Name of proposed project", with: proposal.name
      select "CCCB, CCCB", from: "proposal_lab_group_id"
      select "Affymetrix SNP Array", from: "proposal_platforms"
      fill_in "Other sample type if not listed above", with: "Other sample type"
      fill_in "Objectives", with: proposal.objectives
      fill_in "Background", with: proposal.background
      fill_in "Design details", with: proposal.design_details
      fill_in "Sample availability", with: proposal.sample_availability
      fill_in "Contributions", with: proposal.contributions
      fill_in "Comments", with: proposal.comments
      click_on "Save draft"
    }.to change(SampleType, :count).by(+1)
  end

  scenario "User fills out new proposal form, submits the proposal but does not agree to ccgd policy terms" do
    click_on 'Submit a new proposal'
  
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

  # Unfortunately this scenario fails without JS enabled. Enabling JS does not
  # work on this server unfortunately
  scenario "Admin approves submitted proposal and proposal code generated" do
    admin = create(:admin)
    logout(user)
    login(admin)

    submitted = create(:proposal)
    submitted.ccgd_policy_approval = true
    submitted.proposal_status = ProposalStatus.find(2)
    submitted.save

    visit edit_proposal_path(submitted)

    # Make sure the admin options are displayed
    expect(page).to have_css("#proposal-status-update")

    within "#proposal-status-update" do
      select "complete", from: "Status"
      click_on "Update"
    end

    expect(submitted.proposal_status.id).to be(3)
    #expect(submitted.code).to_not be_nil
  end

  scenario "User edits a saved proposal draft" do
    prop_draft = create(:proposal)
    prop_draft.user = user
    prop_draft.ccgd_policy_approval = true
    prop_draft.save

    visit edit_proposal_path(prop_draft)

    within "h1" do
      expect(page).to have_content("Update #{prop_draft.name} proposal")
    end
    unselect "Sequenom Genotyping", from: "proposal_platforms"
    unselect "Illumina Whole Genome Sequencing", from: "proposal_platforms"
    unselect "RNA", from: "proposal_sample_types"
    select "DNA Fingerprinting", from: "proposal_platforms"
    select "cfDNA", from: "proposal_sample_types"
    click_on "Save draft"

    visit edit_proposal_path(prop_draft)

    expect(page).to have_select("proposal_platforms", selected: ["DNA Fingerprinting"])
    expect(page).to have_select("proposal_sample_types", selected: ["cfDNA"])
=begin
=end
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
