require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  let(:user) { create(:user) }

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    it "returns http success" do
      post :create, session: { user_id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE destroy" do
    it "returns http success" do
      delete :destroy, session: { user_id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

end
