class AdminMailer < ApplicationMailer

  default to: 'dave_rothfarb@dfci.harvard.edu'

  def new_user(user)
    @user = user
    mail(subject: 'New user signup')
  end

  def new_proposal(prop)
    @proposal = prop
    mail(subject: 'New proposal submitted')
  end
end
