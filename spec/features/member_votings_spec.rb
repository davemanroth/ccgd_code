require 'rails_helper'
    #binding.pry

RSpec.feature "MemberVotings", :type => :feature do
  let(:faculty) { create(:faculty) }
  let(:comm) { create(:committee, faculty: faculty) }
  let (:mv) { create(:member_vote, user: faculty) }

  before :each do
    login(faculty)
  end

  scenario "Faculty votes on proposal" do
    visit new_proposal_committee_member_vote_path(comm.proposal, comm, mv)

    # Make sure we're on the right page
    within 'h1' do
      expect(page).to have_content('Committee vote')
    end
  end

end
