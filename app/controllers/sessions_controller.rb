class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      if user.is_pending? || user.is_inactive?
        flash[:danger] = 'Your account has not been approved yet or has been frozen. Please contact the website administrator for more information.'
        redirect_to root_url
      else
        log_in(user)
        redirect_to user
      end
    else
      flash.now[:danger] = 'Invalid username/password, please try again.'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
