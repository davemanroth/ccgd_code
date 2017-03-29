class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #

  def password_reset(user)
    @user = user
    mail to: @user.email, subject: "Password reset"
  end

  def account_approved(user)
    @user = user
    mail to: @user.email, subject: "CCGD account approved"
  end

  def committee_member(committee)
    @proposal = committee.proposal
    @committee = committee
    users = @committee.member_votes.map(&:user)
    emails = users.map(&:email).uniq.join(",")
    mail to: 'dave_rothfarb@dfci.harvard.edu', bcc: emails, subject: "You have been added to a new proposal review committee"
=begin
=end
  end
end
