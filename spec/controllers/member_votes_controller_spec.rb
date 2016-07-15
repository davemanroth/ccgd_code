require 'rails_helper'

RSpec.describe MemberVotesController, :type => :controller do
  let(:comm)  { create(:committee) }
  let(:mv) { create(:member_vote) }

  before :each do
    log_in(mv.user)
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
        id: mv
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH update" do
    it "returns https success" do
      patch :update,
        proposal_id: comm.proposal_id, 
        committee_id: comm,
        id: mv,
        member_vote: attributes_for(:member_vote)
      expect(response).to have_http_status(:success)
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
