module ApplicationHelper

  def item_class(url)
    current_page?(url) ? "active-item" : ""
  end

  # For modal messages
  def message(key)
    messages = {
      user_approval: "The user has been approved",
      proposal_status_update: "The proposal status has been updated",
      vote_cast: "The vote has been cast",
      vote_update: "The vote has been updated"
    }
    messages[key]
  end
end
