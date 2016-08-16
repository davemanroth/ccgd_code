class LocationsController < ApplicationController

  def index
    @locations = Location.all
    render layout: false
  end

  def show
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
  end

  def destroy
    @location = Location.find(params[:id])
  end
end
