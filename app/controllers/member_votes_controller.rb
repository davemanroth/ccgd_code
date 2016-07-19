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
    if !@member_vote
      flash[:error] = "You do not have voting privileges on this proposal"
      redirect_to root_url
    end
  end

  def update
    @proposal = Proposal.find(params[:proposal_id])
    @committee = Committee.find(params[:committee_id])
    @member_vote = MemberVote.find_by(user_id: current_user.id)
    vote = Vote.find(vote_params[:vote])
    if @member_vote.update(vote: vote, comment: vote_params[:comment])
      flash[:success] = "Vote successfully cast"
    else
      flash[:error] = "Error casting vote"
    end
  end

  private
    def vote_params
      params.require(:member_vote).permit(:vote, :comment)
    end
end
