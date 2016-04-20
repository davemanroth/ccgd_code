class AdminMailer < ApplicationMailer

  default to: 'dave_rothfarb@dfci.harvard.edu'

  def new_user(user)
    @user = user
    mail(subject: 'New user signup')
  end
end
