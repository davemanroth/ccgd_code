class AddressesController < ApplicationController
  load_and_authorize_resource
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
    @address = Address.new(address_params)
    if @address.save
      redirect_to configurations_path
      flash[:success] = "New address successfully added"
    else
      flash[:error] = "Error saving address"
      render "new"
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update_attributes(address_params)
      flash[:success] = "Address successfully updated"
      redirect_to configurations_path
    else
      flash[:error] = "Error updating address"
      render "edit"
    end
  end

  def destroy
    Address.find(params[:id]).destroy
    respond_to do |f|
      f.html { redirect_to configurations_path, status: 303 }
    end
  end

  private
    def address_params
      params.require(:address).permit(
        :street, :city, :country, :state_id
      )
    end
end
