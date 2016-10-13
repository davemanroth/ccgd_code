module ProposalsHelper

  def on_committee?(prop)
    if prop.committee
      prop.committee.member_votes.where(user_id: current_user).pluck(:id).first
    end
  end

  def voted?(vote_id)
    member_vote = MemberVote.find(vote_id) if vote_id
    !member_vote.nil? and !member_vote.vote_id.nil?
  end
end
