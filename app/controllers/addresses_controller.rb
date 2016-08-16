class AddressesController < ApplicationController
  def index
    @addresses = Address.all
    render layout: false if params[:rendering]
  end

  def show
    @address = Address.find(params[:id])
  end

  def new
    @address = Address.new
  end

  def create
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
  end

  def destroy
    @address = Address.find(params[:id])
  end
end
