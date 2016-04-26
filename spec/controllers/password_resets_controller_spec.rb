require 'rails_helper'

RSpec.describe PasswordResetsController, :type => :controller do
  let(:user) { build(:user) }

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET edit" do
    it "generates a password reset token and tests reset url" do
      user.generate_token(:password_reset_token)
      user.save
      get :edit, id: user.password_reset_token
      expect(response).to have_http_status(:success)
    end
  end

end
