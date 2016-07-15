require 'rails_helper'

RSpec.describe CommitteesController, :type => :controller do
  let(:comm) { create(:committee) }

  let(:admin) { create(:admin) }

  before :each do
    log_in(admin)
  end
=begin
=end
  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new, proposal_id: comm.proposal_id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, proposal_id: comm.proposal_id, id: comm
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    it "creates a new committee" do
      expect {
        post :create, proposal_id: comm.proposal_id, committee: attributes_for(:committee)
      }.to change(Committee, :count).by(1)
    end
  end

  describe "PATCH update" do
    context "http request" do
      it "returns http success" do
        patch :update, 
          proposal_id: comm.proposal_id, 
          id: comm,
          committee: attributes_for(:committee)
        expect(response).to have_http_status(:success)
      end
    end

    context "updating committee data" do
      it "locates the correct committee" do
        patch :update, 
          proposal_id: comm.proposal_id, 
          id: comm,
          committee: attributes_for(:committee)
        # binding.pry
        expect(assigns(:committee)).to eq(comm)
      end

=begin
      it "updates fields on a committee" do
        patch :update, 
          proposal_id: comm.proposal_id, 
          id: comm,
          committee: attributes_for(:committee,
            # To be completed later
          )
        comm.reload
        expect(comm.id).to eq(20)
      end
=end
    end
  end

  describe "DELETE destroy" do
    it "deletes a committee" do
      comm.save
      expect {
        delete :destroy, 
          proposal_id: comm.proposal_id,
          id: comm
      }.to change(Committee, :count).by(-1)
    end
  end

end
