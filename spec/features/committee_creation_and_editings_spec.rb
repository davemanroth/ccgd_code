require 'rails_helper'

RSpec.feature "Admin committee creation and editing", :type => :feature do
  let(:admin) { create(:admin) }

  before :each do
    login(admin)
  end

  scenario "Admin creates a new committee and adds members" do
    prop = create(:proposal)
    visit new_proposal_committee_path(prop)

    within 'h1' do
      expect(page).to have_content('Form a new committee')
    end

=begin
    within ".deadline-select" do
      select "10", from: "committee_deadline_3i"
    end
=end
    expect {
      select "10", from: "committee_deadline_3i"
      select "Adam Bass", from: "faculty"
      select "Levi Garraway", from: "faculty"
      select "Anna Cooley", from: "advisors"
      select "Sam Hunter", from: "advisors"
      click_on "Form committee"
    }.to change(Committee, :count).by(+1)
  end

  scenario "Admin edits existing committee" do
    comm = create(:three_member)
    members = comm.users

    visit edit_proposal_committee_path(comm.proposal, comm)

    within 'h1' do
      expect(page).to have_content('Edit a committee')
    end

    within ".committee-members" do
      expect(page).to have_select("faculty", selected: "Adam Bass")
    end
  end

end
