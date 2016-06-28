require 'rails_helper'

RSpec.describe CommitteesController, :type => :controller do
  let(:comm) { create(:committee) }

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
      it "retruns http success" do
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
        expect(assigns(:committee)).to eq(comm)
      end

      it "updates fields on a committee" do
        patch :update, 
          proposal_id: comm.proposal_id, 
          id: comm,
          committee: attributes_for(:committee,
            deadline: Time.now + 86400
          )
        comm.reload
        expect(comm.deadline).to eq(Time.now + 86400)
      end
    end
  end

end
