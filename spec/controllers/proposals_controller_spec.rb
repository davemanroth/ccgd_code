require 'rails_helper'

RSpec.describe ProposalsController, :type => :controller do
  let(:admin) { create(:admin) }
  let(:prop) { create(:proposal) }

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
      get :show, id: prop
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :show, id: prop
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    it "creates a new proposal" do
      expect {
        post :create, proposal: attributes_for(:proposal)
      }.to change(Proposal, :count).by(1)
    end
  end

  describe "PATCH update" do
    context "http request" do
      it "returns http success" do
        patch :update, id: prop, proposal: attributes_for(:proposal)
        expect(response).to have_http_status(:success)
      end
    end

    context "updating proposal data" do
      it "locates the correct proposal" do
        patch :update, id: prop, proposal: attributes_for(:proposal)
        expect(assigns(:proposal)).to eq(prop)
      end

      it "updates fields on a proposal" do
        patch :update, id: prop,
        proposal: attributes_for(:proposal,
          name: 'A new proposal name',
          comments: 'Some new comments'
        )
        prop.reload
        expect(prop.name).to eq('A new proposal name')
        expect(prop.comments).to eq('Some new comments')
      end
    end

  end

  describe "DELETE destroy" do
    it "deletes a proposal" do
      prop.save
      expect {
        delete :destroy, id: prop
      }.to change(Proposal, :count).by(-1)
    end
  end
=begin
=end

end
