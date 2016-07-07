module CommitteesHelper

  def selected(group, member_votes, role)
    if !member_votes.empty?
      member_votes.where(member_role: role).pluck(:user_id)
    end
  end

end
