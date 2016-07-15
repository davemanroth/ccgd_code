class MemberVotesController < ApplicationController
  load_and_authorize_resource

  def new
    @proposal = Proposal.find(params[:proposal_id])
    @committee = Committee.find(params[:committee_id])
    @member_vote = MemberVote.find_by(user_id: current_user.id)
  end

  def create
    @proposal = Proposal.find(params[:proposal_id])
    @committee = Committee.find(params[:committee_id])
    @member_vote = MemberVote.find_by(user_id: current_user.id)
  end

  def edit
    @proposal = Proposal.find(params[:proposal_id])
    @committee = Committee.find(params[:committee_id])
    @member_vote = MemberVote.find_by(user_id: current_user.id)
  end

  def update
    @proposal = Proposal.find(params[:proposal_id])
    @committee = Committee.find(params[:committee_id])
    @member_vote = MemberVote.find_by(user_id: current_user.id)
  end
end
