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
    @address = Address.new(address_params)
    if @address.save
      flash[:success] = "New address successfully added"
      redirect_to "configurations"
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
      redirect_to "configurations"
    else
      flash[:error] = "Error updating address"
      render "edit"
    end
  end

  def destroy
    Address.find(params[:id]).destroy
    flash[:success] = "Address has been deleted"
  end

  private
    def address_params
      params.require(:address).permit(
        :street, :city, :country, :state_id
      )
    end
end
