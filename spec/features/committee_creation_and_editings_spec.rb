require 'rails_helper'

RSpec.feature "Admin committee creation and editing", :type => :feature do
  let(:admin) { create(:admin) }

  before :each do
    login(admin)
  end

  scenario "Admin creates a new committee and adds members" do
    prop = create(:proposal)
    visit new_proposal_committee_path(prop)

    # Make sure we're on the right page
    within 'h1' do
      expect(page).to have_content('Form a new committee')
    end

    expect {
      select "20", from: "committee_deadline_3i"
      select "Under committee review", from: "status"
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

    # Check the page title to make sure we're on the edit committee page
    within 'h1' do
      expect(page).to have_content('Edit a committee')
    end

    # Check that the select boxes have the current committee members
    # preselected
    within ".committee-members" do
      expect(page).to have_select("faculty", selected: [members[0].full_name, members[1].full_name])
      expect(page).to have_select("advisors", selected: [members[2].full_name])
    end

    within ".status" do
      select "Under committee review", from: "status"
    end

    within ".committee-members" do
      unselect members[0].full_name, from: "faculty"
      unselect members[1].full_name, from: "faculty"
      unselect members[2].full_name, from: "advisors"
      select "Adam Bass", from: "faculty"
      select "Levi Garraway", from: "faculty"
      select "Anna Cooley", from: "advisors"
      select "Sam Hunter", from: "advisors"
    end
    click_on "Update committee"
    comm.reload

    #binding.pry
    expect(comm.users.count).to be(4)

    within ".status" do
      expect(page).to have_select("status", selected: "Under committee review")
    end

=begin
=end
    #binding.pry
    within ".committee-members" do
      expect(page).to have_select("faculty", selected: ["Adam Bass", "Levi Garraway"])
      expect(page).to have_select("advisors", selected: ["Anna Cooley", "Sam Hunter"])
    end
  end

end
