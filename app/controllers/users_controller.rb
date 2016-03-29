class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @locations = Location.all.order(building: :asc)
    @organizations = Organization.all
    @labgroups = LabGroup.all
  end

  def create
    @user = User.new(params[:user])
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
end
