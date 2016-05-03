class UsersController < ApplicationController
  include UsersHelper
  load_and_authorize_resource except: [:new, :create]

  def index
    @users = User.all
    authorize! :index, @users
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if !lab_group_params.nil?
      add_lab_groups(@user)
    end

    if !custom_org_params.empty?
      if organization_selected?(user_params)
        @user.errors.add(:user_custom_organization_id, "If you've already selected an organization, you cannot add new one")
      else
        uco = UserCustomOrganization.create(custom_org_params)
        @user.user_custom_organization_id = uco.id
      end
    end

=begin
    if !custom_org_params.nil?
      uco = UserCustomOrganization.create(custom_org_params)
      @user.user_custom_organization_id = uco
    end
=end

    if @user.save
      # Rails.logger.debug(params)
      #AdminMailer.new_user(@user).deliver_now
      flash[:success] = "An email has been sent to the CCGD admin. You will receive login information shortly"
      log_in(@user)
      redirect_to @user
    else
      flash[:error] = "There was a problem with your form submission. See errors below"
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if !lab_group_params.nil?
      add_lab_groups(@user)
    end

    if !admin_update_params.nil?
      apply_admin_updates(@user)
    end

    if @user.update_attributes(user_params)
      flash[:success] = "Profile successfully updated"
      redirect_to @user
    else
      flash[:error] = "There was a problem, profile could not be updated"
      render 'edit'
    end

  end

  def destroy
    User.find(params[:id]).destroy
  end

  def status_update
    @user = User.find(params[:id])
    @user.status = params[:status]
    if @user.save
      respond_to do |f|
        f.html
      end
      flash[:error] = "Could not update status"
    end
    authorize! :status_update, @user
  end

  private
    def user_params
      params.require(:user).permit(
        :firstname, :lastname, 
        :email, :phone, :username, 
        :password, :password_confirmation,
        :organization_id, :ccgd_policy
      )
    end

    # Separate out labgroups array
    def lab_group_params
      params.require(:user).permit(lab_groups:[])
    end

    # Separate out admin update privileges
    def admin_update_params
      params.require(:user).permit(:status, roles:[])
    end

    def custom_org_params
      params.permit(
        :custom_org_name, :custom_org_phone,
        :custom_org_email, :custom_org_street,
        :custom_org_city, :custom_org_country, :state_id
      )
    end

    def custom_labgroup_params
    end

end
