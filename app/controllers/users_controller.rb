class UsersController < ApplicationController
  include UsersHelper
  load_and_authorize_resource except: [:new, :create]

  def index
    @users = User.all
    authorize! :review, User
  end

  def show
    @user = User.find(params[:id])
    @proposals = Hash.new
    @proposals[:submitted] = Proposal.non_draft.where(user_id: @user.id)
    @proposals[:drafts] = Proposal.where(user_id: @user.id, proposal_status: 1)
    @proposals[:revisions] = Proposal.where(user_id: @user.id, proposal_status: 8)
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
      redirect_to root_url
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
    new_status = user_params[:status]

    if lab_group_params
      add_lab_groups(@user)
    end

    if admin_update_params
      apply_admin_updates(@user)
    end


    if @user.update_attributes(user_params)
      # This is a stupid but necessary hack to reassign an "Active" status to
      # the user because for some reason the user's status gets randomly nulled
      # out as soon as the update_atributes method is executed. Bizarre.
      if @user.is_pending? && new_status == 'A'
        send_approve_email(@user)
      end
      @user.status ||= 'A'
      @user.save
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
    new_status = params[:status]
    @user.status = new_status
    if @user.save
      if @user.is_pending? && new_status == 'A'
        send_approve_email(@user)
      end
      respond_to do |f|
        f.html
      end
    end
    authorize! :status_update, @user
  end

  def send_approve_email(user)
    UserMailer.account_approved(user).deliver_now
  end

  private
    def user_params
      params_array = [
        :firstname, :lastname, 
        :email, :phone, :username, 
        :password, :password_confirmation,
        :organization_id, :ccgd_policy, :status
      ]

      # Check to see if anything entered in the custom org form, if so, add to
      # array
      if !params[:user][:user_custom_organization_attributes][:custom_org_name].empty?
        params_array <<  { user_custom_organization_attributes: [
          :id, :custom_org_name, :custom_org_phone,
          :custom_org_email, :custom_street,
          :custom_city, :custom_country, :state_id
        ] }
      end
      
      # Check to see if anything entered in the custom org form, if so, add to
      # array
      if !params[:user][:user_custom_labgroup_attributes][:custom_labgroup_name].empty?
        params_array << { user_custom_labgroup_attributes: [
          :id, :custom_labgroup_name, :custom_labgroup_code,
          :custom_labgroup_building, :custom_labgroup_room,
          :custom_street, :custom_city, 
          :custom_country, :state_id
        ] }
      end
      params.require(:user).permit(params_array)
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
