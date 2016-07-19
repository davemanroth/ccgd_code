require 'rails_helper'

RSpec.describe MemberVotesController, :type => :controller do
  let(:comm)  { create(:committee) }
  let(:approve) { create(:approve_vote) }

  before :each do
    log_in(approve.user)
  end

  describe "GET new" do
    it "returns http success" do
      get :new, 
        proposal_id: comm.proposal_id, 
        committee_id: comm
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit,
        proposal_id: comm.proposal_id, 
        committee_id: comm,
        id: approve
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH update" do
    context "http request" do
      it "returns https success" do
        patch :update,
          proposal_id: comm.proposal_id, 
          committee_id: comm,
          id: approve,
          member_vote: attributes_for(:approve_vote)
        expect(response).to have_http_status(:success)
      end
    end
    context "casting vote" do
      it "locates the correct proposal and voting form" do
        patch :update,
          proposal_id: comm.proposal_id, 
          committee_id: comm,
          id: approve,
          member_vote: attributes_for(:approve_vote)
        expect(assigns(:approve_vote)).to eq(approve)
      end
    end
  end

=begin
  describe "GET update" do
    it "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end
=end

end
