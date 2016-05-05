class OrganizationsController < ApplicationController
  def create
    uco = UserCustomOrganization.find(params[:org_id])
  end
end
