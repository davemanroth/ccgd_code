require "rails_helper"

RSpec.describe AdminMailer, :type => :mailer do

  let(:user) { create(:user) }
  let (:email) { AdminMailer.new_user(user).deliver_now }

  it "should be in the deliveries queue" do
    expect(ActionMailer::Base.deliveries).to_not be_empty
  end

  it "should have the correct from address" do
    expect(email.from.first).to eq 'ccgd@research.dfci.harvard.edu'
  end

  it "should have the correct to address" do
    expect(email.to.first).to eq 'dave_rothfarb@dfci.harvard.edu'
  end

  it "should have the correct subject" do
    expect(email.subject).to eq 'New user signup'
  end

end
