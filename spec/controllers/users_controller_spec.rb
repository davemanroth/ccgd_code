require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  let(:user) { create(:user) }

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET show" do
    it "returns http success" do
      get :show, id: user
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  /
  /
  describe "POST create" do
    it "adds a new user" do
      expect{
        post :create, id: user
      }.to change(User, :count).by(+1)
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, id: user
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH update" do
    it "returns http success" do
      patch :update, id: user
      expect(response).to have_http_status(:success)
    end

  /
    it "updates a user's information" do
      patch :update, id: user,
      user: attributes_for(:user,
        firstname: 'Bruce',
        lasname: 'Wayne'
      )
      user.reload
      expect(user.firstname).to eq('Bruce')
      expect(user.lastname).to eq('Wayne')
    end 
  /
  end

  describe "DELETE destroy" do
    user = FactoryGirl.create(:user)
    it "deletes the user" do
      expect{
        delete :destroy, id: user
      }.to change(User, :count).by(-1)
    end
  end

end
