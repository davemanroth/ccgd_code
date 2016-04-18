require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  let!(:admin) { create(:admin) }

  before :each do
    log_in(admin)
  end

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET show" do
    it "returns http success" do
      get :show, id: admin
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
      get :edit, id: admin
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH update" do
    context "simple http request" do
      it "returns http success" do
        patch :update, id: admin, user: attributes_for(:user)
        expect(response).to have_http_status(:success)
      end
    end

    context "updating data" do
      it "locates the requested user" do
        patch :update, id: admin, user: attributes_for(:user)
        expect(assigns(:user)).to eq(admin)
      end

      it "updates a user's information" do
        patch :update, id: admin,
        user: attributes_for(:user,
          firstname: 'Bruce',
          lastname: 'Wayne'
        )
        admin.reload
        expect(admin.firstname).to eq('Bruce')
        expect(admin.lastname).to eq('Wayne')
      end 
    end
  end

  describe "POST create" do
    it "adds a new admin" do
      expect{
        post :create, user: attributes_for(:user)
      }.to change(User, :count).by(+1)
    end
  end

  describe "DELETE destroy" do
    it "deletes the admin" do
      expect{
        delete :destroy, id: admin
      }.to change(User, :count).by(-1)
    end
  end
end
