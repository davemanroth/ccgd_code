class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    user.send_password_reset if user
    flash[:success] = "Email sent with password reset information"
    redirect_to root_url
  end

  def edit
    @user = User.find_by!(email: params[:email])
  end

  def update
    @user = User.find_by!(email: params[:email])
    if @user.password_reset_sent_at < 2.hours.ago
      flash[:error] = "Password reset has expired"
      redirect_to new_password_reset_path
    elsif @user.update_attributes(user_params)
      flash[:success] = "Password successfully updated"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

end
