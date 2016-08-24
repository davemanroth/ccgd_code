class UserCustomOrganizationsController < ApplicationController
  def destroy
    UserCustomOrganization.find(params[:id]).destroy
  end
end
