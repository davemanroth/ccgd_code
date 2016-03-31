require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  let!(:user) { create(:user) }

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

  describe "GET edit" do
    it "returns http success" do
      get :edit, id: user
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH update" do
    context "simple http request" do
      it "returns http success" do
        patch :update, id: user
        expect(response).to have_http_status(:success)
      end
    end

    context "updating data" do
      it "locates the requested user" do
        patch :update, id: user, user: attributes_for(:user)
        expect(assigns(:user)).to eq(user)
      end

      it "updates a user's information" do
        patch :update, id: user,
        user: attributes_for(:user,
          firstname: 'Bruce',
          lastname: 'Wayne'
        )
        user.reload
        puts user.firstname
        expect(user.firstname).to eq('Bruce')
        expect(user.lastname).to eq('Wayne')
      end 
    end
  end

  describe "POST create" do
    it "adds a new user" do
      expect{
        post :create, user: attributes_for(:user)
      }.to change(User, :count).by(+1)
    end
  end

  describe "DELETE destroy" do
    it "deletes the user" do
      expect{
        delete :destroy, id: user
      }.to change(User, :count).by(-1)
    end
  end
end
