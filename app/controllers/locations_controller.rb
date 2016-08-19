class LocationsController < ApplicationController
  load_and_authorize_resource

  def index
    @locations = Location.all
    render layout: false if params[:rendering]
  end

  def show
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      flash[:success] = "New location successfully added"
      redirect_to configurations_path
    else
      flash[:error] = "Error saving location"
      render "new"
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    if @location.update_attributes(location_params)
      flash[:success] = "Location successfully updated"
      redirect_to configurations_path
    else
      flash[:error] = "Error updating location"
      render "edit"
    end
  end

  def destroy
    Location.find(params[:id]).destroy
    respond_to do |f|
      f.html { redirect_to configurations_path, status: 303 }
    end
  end

  private
    def location_params
      params.require(:location).permit(
        :building, :room, :address_id
      )
    end

end
