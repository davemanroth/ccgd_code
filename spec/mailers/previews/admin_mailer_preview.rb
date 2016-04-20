class AdminMailerPreview < ActionMailer::Preview
  def new_user
    user = User.first
    AdminMailer.new_user(user)
  end
end
