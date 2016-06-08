require 'rails_helper'

RSpec.describe OrganizationsController, :type => :controller do

  describe "GET create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE destroy" do
    it "deletes an organization" do
      prop.save
      expect {
        delete :destroy, id: prop
      }.to change(Proposal, :count).by(-1)
    end
  end

end
