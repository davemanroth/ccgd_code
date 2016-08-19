class OrganizationsController < ApplicationController
  include AddressHelper
  load_and_authorize_resource except: [:new, :create]

  def index
    @organizations = Organization.all
    render layout: false if params[:rendering]
  end

  def new
    @organization = Organization.new
  end

  def create
    # Check to see if new org created via admin create org form
    if params[:form_type] == 'admin'
      @organization = Organization.new(admin_org_params)
      if @organization.save
        flash[:success] = "New organization successfully added"
        redirect_to configurations_path
      else
        flash[:error] = "Error saving organization"
        render "new"
      end
    else
    # If not from admin create form, handle org creation via new user form
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
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])
    if @organization.update_attributes(admin_org_params)
      flash[:success] = "Organization successfully updated"
      redirect_to configurations_path
    else
      flash[:error] = "Error updating organization"
      render "edit"
    end
  end

  def destroy
    if org_params[:org_id]
      UserCustomOrganization.find(org_params[:org_id]).destroy
    else
      Organization.find(params[:id]).destroy
      respond_to do |f|
        f.html { redirect_to configurations_path, status: 303 }
      end
    end
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

    def admin_org_params
      params.require(:organization).permit(
        :name, :phone, :email, :address_id
      )
    end
end
