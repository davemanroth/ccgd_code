class PlatformsController < ApplicationController
  load_and_authorize_resource

  def index
    @platforms = Platform.all
    render layout: false if params[:rendering]
  end

  def show
  end

  def new
    @platform = Platform.new
  end

  def create
    @platform = Platform.new(platform_params)
    if @platform.save
      flash[:success] = "New platform successfully added"
      redirect_to configurations_path
    else
      flash[:error] = "Error saving platform"
      render "new"
    end
  end

  def edit
    @platform = Platform.find(params[:id])
  end

  def update
    @platform = Platform.find(params[:id])
    if @platform.update_attributes(platform_params)
      flash[:success] = "Platform successfully updated"
      redirect_to configurations_path
    else
      flash[:error] = "Error updating platform"
      render "edit"
    end
  end

  def destroy
    Platform.find(params[:id]).destroy
    respond_to do |f|
      f.html { redirect_to configurations_path, status: 303 }
    end
  end

  private
    def platform_params
      params.require(:platform).permit(:name, :code)
    end

end
