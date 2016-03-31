class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "An email has been sent to the CCGD admin. You will receive login information shortly"
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

  private
    def user_params
      params.require(:user).permit(
        :firstname, :lastname, 
        :email, :phone, :username, 
        :password, :password_confirmation,
        :location_id, :organization_id, :lab_groups
      )
    end
end
