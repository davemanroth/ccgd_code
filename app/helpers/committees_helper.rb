module CommitteesHelper

  def selected(member_votes, role)
    if !member_votes.empty?
      group = member_votes.where(member_role: role).pluck(:user_id)
    end
  end

  def members_that_voted(member_votes)
    if !member_votes.empty?
      result = member_votes.where.not(vote_id: nil)
      result.count
    end
  end

end
