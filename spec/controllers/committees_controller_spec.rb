require 'rails_helper'

RSpec.describe CommitteesController, :type => :controller do
  let(:prop) { create(:proposal) }
  let(:comm) { create(:committee) }

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new, proposal_id: prop
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, proposal_id: prop, id: comm
      expect(response).to have_http_status(:success)
    end
  end

end
