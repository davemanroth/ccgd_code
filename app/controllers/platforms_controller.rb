class PlatformsController < ApplicationController
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
    @platform = Platform.new
  end

  def edit
    @platform = Platform.find(params[:id])
  end

  def update
    @platform = Platform.find(params[:id])
  end

  def destroy
    @platform = Platform.find(params[:id])
  end
end
