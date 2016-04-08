class UsersController < ApplicationController

  def index
    @users = User.non_inactive
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
      
    if @user.save
      flash[:success] = "An email has been sent to the CCGD admin. You will receive login information shortly"
      log_in(@user)
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
  end

  def status_update
    @user = User.find(params[:id])
    @user.status = params[:status].upcase
    if @user.save
      respond_to do |f|
        # f.js
      end
      flash.now[:success] = "#{@user.firstname}'s status was updated"
      /
        /
    else
      flash[:error] = "Could not update status"
    end
  end

  private
    def user_params
      params.require(:user).permit(
        :firstname, :lastname, 
        :email, :phone, :username, 
        :password, :password_confirmation,
        :location_id, :organization_id
      )
    end

    # Separate out labgroups array
    def lab_group_params
      params.require(:user).permit(lab_groups:[])
    end

    # Add labgroup records to user object
    def add_lab_groups(user)
      vals = lab_group_params.values.first
      vals.each do |id|
        if !id.empty?
          lg = LabGroup.find(id)
          user.lab_groups << lg
        end
      end
    end

end
