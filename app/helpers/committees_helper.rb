module CommitteesHelper

  def selected(member_votes, role)
    if !member_votes.empty?
      group = member_votes.where(member_role: role).pluck(:user_id)
    end
  end

end
