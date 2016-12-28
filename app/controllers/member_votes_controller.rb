class MemberVotesController < ApplicationController
  load_and_authorize_resource

  def index
    @proposal = Proposal.find(params[:proposal_id])
    @committee = Committee.find(params[:committee_id])
    @member_votes = MemberVote.where(committee_id: @committee)
  end

  def show
    @proposal = Proposal.find(params[:proposal_id])
    @committee = Committee.find(params[:committee_id])
    @member_vote = MemberVote.find(params[:id])
    check_member_vote(@committee, @member_vote)
  end

  def edit
    @proposal = Proposal.find(params[:proposal_id])
    @committee = Committee.find(params[:committee_id])
    @member_vote = MemberVote.find(params[:id])
    check_member_vote(@committee, @member_vote)
  end

  def update
    @proposal = Proposal.find(params[:proposal_id])
    @committee = Committee.find(params[:committee_id])
    @member_vote = MemberVote.find(params[:id])

    # Check if this vote is being updated by an admin or the currently logged
    # in committee member
    if submitter = params[:submitter]
      if User.find(submitter).has_role?(1) # role 1 = admin
        @member_vote = MemberVote.find(params[:id])
        comment = params[:member_vote][:comment]
        choice = params[:member_vote]["vote_#{@member_vote.id}"]
        vote = Vote.find(choice)
      end
    # If vote not being updated by admin, vote params should not be nil. Handle
    # error and break out of update action
    elsif vote_params[:vote].nil?
      flash[:error] = "You must choose to approve, reject, or request proposal revision"
      render "new"
      return
    else
      comment = vote_params[:comment]
      vote = Vote.find(vote_params[:vote])
    end

    if @member_vote.update!(vote: vote, comment: comment)
      flash[:success] = "Vote successfully cast"
      respond_to do |f|
        f.html { redirect_to edit_proposal_committee_member_vote_path(@proposal, @committee, @member_vote), status: 303 }
      end
    else
      flash[:error] = "Error casting vote"
      render "new"
    end
  end

  private
    def vote_params
      params.require(:member_vote).permit(:vote, :comment)
    end

    def check_member_vote(committee, member_vote)
      if !member_vote or !is_on_committee?(committee)
        flash[:error] = "You do not have voting privileges on this proposal"
        redirect_to root_url
      end
    end

    def is_on_committee?(committee)
      user = User.joins(committee: :member_votes).where(committee: committee, member_votes: { user_id: current_user })
    end
end
