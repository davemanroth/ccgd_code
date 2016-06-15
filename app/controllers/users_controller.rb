class UsersController < ApplicationController
  include UsersHelper
  load_and_authorize_resource except: [:new, :create]

  def index
    @users = User.all
    authorize! :index, @users
  end

  def show
    @user = User.find(params[:id])
    @proposals = Hash.new
    @proposals[:submitted] = Proposal.non_draft.where(user_id: @user.id)
    @proposals[:drafts] = Proposal.where(user_id: @user.id, proposal_status: 1)
    @proposals.each do |key, val|
      if val && val.is_a?(Proposal)
        @proposals[key] = [val]
      end
    end
  end

  def new
    @user = User.new
    initialize_custom_fields(@user)
  end

  def create
    @user = User.new(user_params)

    if !lab_group_params.nil?
      add_lab_groups(@user)
    end

    if @user.save
      #Rails.logger.debug(@user)
      AdminMailer.new_user(@user).deliver_now
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
    initialize_custom_fields(@user)
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
=begin
=end
    User.find(params[:id]).destroy
    flash[:success] = "User has been deleted"
    redirect_to users_path
  end

  def user_status_update
    @user = User.find(params[:id])
    @user.status = params[:status]
    if @user.save
      respond_to do |f|
        f.html
      end
    end
    authorize! :status_update, @user
  end

  private
    def user_params
      params.require(:user).permit(
        :firstname, :lastname, 
        :email, :phone, :username, 
        :password, :password_confirmation,
        :organization_id, :ccgd_policy,
        user_custom_organization_attributes: [
          :id, :custom_org_name, :custom_org_phone,
          :custom_org_email, :custom_street,
          :custom_city, :custom_country, :state_id
        ],
        user_custom_labgroup_attributes: [
          :id, :custom_labgroup_name, :custom_labgroup_code,
          :custom_labgroup_building, :custom_labgroup_room,
          :custom_street, :custom_city, 
          :custom_country, :state_id
        ]
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

end
