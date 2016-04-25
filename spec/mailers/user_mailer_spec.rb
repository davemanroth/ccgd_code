require "rails_helper"

RSpec.describe UserMailer, :type => :mailer do
  describe "password_reset" do
    let(:mail) { UserMailer.password_reset }

    it "should have the correct from address" do
      expect(mail.from.first).to eq 'ccgd@research.dfci.harvard.edu'
    end

    it "should have the correct to address" do
      expect(mail.to.first).to eq 'dave_rothfarb@dfci.harvard.edu'
    end

    it "should have the correct subject" do
      expect(mail.subject).to eq 'New user signup'
    end


    it "renders the headers" do
      expect(mail.subject).to eq("Password reset")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
