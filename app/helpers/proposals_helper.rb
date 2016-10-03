module ProposalsHelper

  def voted?(proposal)
    member_vote = MemberVote.find(vote_id(proposal))
    #binding.pry
    !member_vote.nil? and !member_vote.vote_id.nil?
  end

  def vote_id(proposal)
    proposal.committee.member_votes.where(user_id: current_user).pluck(:id).first
  end
end
