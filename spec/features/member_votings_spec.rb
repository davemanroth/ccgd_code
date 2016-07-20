require 'rails_helper'

RSpec.feature "MemberVotings", :type => :feature do
  let(:faculty) { create(:faculty) }
  let(:three_member) { create(:three_member) }
  let (:mv) { create(:member_vote, user: faculty, member_role: 2) }

  before :each do
    login(faculty)
    three_member.member_votes << mv
    visit new_proposal_committee_member_vote_path(three_member.proposal, three_member, mv)

    # Make sure we're on the right page
    within 'h1' do
      expect(page).to have_content('Committee vote')
    end
  end

  scenario "Faculty votes on proposal" do

    # Vote to approve proposal
    within ".edit_member_vote" do
      choose "member_vote_vote_1"
      fill_in "member_vote_comment", with: mv.comment
      click_on "Cast vote"
    end

    # Check to make sure success flash message appears
    within ".alert" do
      expect(page).to have_content("Vote successfully cast")
    end

    # Check to make sure submitted vote values made it to factory instances
    three_member.reload
    voted = three_member.member_votes.last
    expect(voted.vote.name).to eq("Approve")
    expect(voted.comment).to eq(mv.comment)
  end

  scenario "Faculty submits voting form without voting" do

    # Vote to approve proposal
    within ".edit_member_vote" do
      click_on "Cast vote"
    end

    # Check to make sure success flash message appears
    within ".alert" do
      expect(page).to have_content("You must choose to approve, reject, or request proposal revision")
    end
  end


end
