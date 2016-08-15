class LocationsController < ApplicationController

  def index
    @locations = Location.all
    render layout: false
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
