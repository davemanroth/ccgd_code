class UserCustomOrganizationsController < ApplicationController
  def destroy
    UserCustomOrganization.find(params[:org_id]).destroy
    respond_to do |format|
      format.js { render partial: 'shared/add_success' }
    end
  end
end
