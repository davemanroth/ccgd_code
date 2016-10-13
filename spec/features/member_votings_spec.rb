require 'rails_helper'

RSpec.feature "MemberVotings", :type => :feature do
  let(:faculty) { create(:faculty) }
  let(:three_member) { create(:three_member) }
  let (:mv) { create(:member_vote, user: faculty, member_role: 2) }

  before :each do
    login(faculty)
    three_member.member_votes << mv
  end

  scenario "Faculty votes on proposal" do
   
    # Make sure we're on the right page
    visit edit_proposal_committee_member_vote_path(three_member.proposal, three_member, mv)
    within 'h1' do
      expect(page).to have_content('Committee vote')
    end

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

    # Make sure we're on the right page
    visit new_proposal_committee_member_vote_path(three_member.proposal, three_member, mv)
    within 'h1' do
      expect(page).to have_content('Committee vote')
    end

    # Vote to approve proposal
    within ".edit_member_vote" do
      click_on "Cast vote"
    end

    # Check to make sure success flash message appears
    within ".alert" do
      expect(page).to have_content("You must choose to approve, reject, or request proposal revision")
    end
  end

  scenario "Faculty tries to access voting page for proposal he/she is NOT assigned" do
    mv.user = create(:advisor)
    mv.save
    visit new_proposal_committee_member_vote_path(three_member.proposal, three_member, mv)

    within ".alert" do
      expect(page).to have_content("You do not have voting privileges on this proposal")
    end
  end

  scenario "Faculty goes to proposals list page, casts vote with 'Vote' button, revisits proposals list page, and edits existing vote with 'Edit vote' button" do
    visit proposals_path

    within "table" do
      expect(page).to have_content(three_member.proposal.name)
      click_on "Vote"
    end

    within "h1" do
      expect(page).to have_content("Committee vote")
    end

    within ".edit_member_vote" do
      choose "member_vote_vote_1"
      fill_in "member_vote_comment", with: mv.comment
      click_on "Cast vote"
    end

    visit proposals_path

    within "table" do
      expect(page).to have_content("Edit vote")
    end
  end

  scenario "Admin accesses member votes list page and votes for a member that did not cast a vote" do

    # First make sure faculty is not logged in and log in admin instead
    logout(faculty)
    admin = create(:admin)
    comm = create(:committee)

    # assign a committee member to the committee
    comm.member_votes << mv
    comm.save

    login(admin)
    visit proposal_committee_member_votes_path(comm.proposal, comm)

    # Make sure we're on the right page
    within "h1" do
      expect(page).to have_content("Committee voting results")
    end

    # Make sure the committee member is listed in the table of voters
    radio_button = "member_vote_vote_#{mv.id}_1"
    within ".member-vote-table" do
      expect(page).to have_content(mv.user.username)

      # Choose to approve the proposal and click the Vote button
      choose radio_button
      fill_in "member_vote_comment", with: mv.comment
      click_on "Vote"
    end

    # Make sure the member vote object recorded and saved the Approve vote
    mv.reload

    db_mv = MemberVote.find(mv.id)
    expect(db_mv.comment).to eq(mv.comment)
    expect(db_mv.vote.name).to eq("Approve")

  end


end
