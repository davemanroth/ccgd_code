class AdminMailer < ApplicationMailer

  default to: 'aaron_thorner@dfci.harvard.edu'
  # default to: 'dave_rothfarb@dfci.harvard.edu'

  def new_user(user)
    @user = user
    mail(subject: 'New user signup', bcc: ['dave_rothfarb@dfci.harvard.edu'])
  end

  def new_proposal(prop)
    @proposal = prop
    mail(subject: 'New proposal submitted', bcc: ['dave_rothfarb@dfci.harvard.edu'])
  end
end
