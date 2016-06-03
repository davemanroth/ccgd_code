class OrganizationsController < ApplicationController
  include AddressHelper

  def create
    uco = UserCustomOrganization.find(org_params[:org_id])
    user = User.find(uco.user_id)
    if !uco.nil?
      address = add_address(uco)
      org = load_org(uco, address.id)
      if org.save
        flash[:success] = 'Organization added'
        user.update(organization: org)
        uco.destroy
      else
        flash[:error] = 'An error occurred'
      end
    end
    respond_to do |format|
      format.js { render partial: 'shared/add_success' }
      format.html
    end
  end

  def destroy
    UserCustomOrganization.find(org_params[:org_id]).destroy
  end

  private 

    def load_org(uco, address_id)
      Organization.new(
        name: uco.custom_org_name,
        phone: uco.custom_org_phone,
        email: uco.custom_org_email,
        address_id: address_id
      )
    end

    def org_params
      params.permit(:org_id)
    end
end
