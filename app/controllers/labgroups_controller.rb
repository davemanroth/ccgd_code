class LabgroupsController < ApplicationController
  include AddressHelper

  def index
    @lab_groups = LabGroup.all
    render layout: false if params[:rendering]
  end

  def new
  end

  def create
    ucl = UserCustomLabgroup.find(lab_params[:lab_id])
    user = User.find(ucl.user_id)
    if !ucl.nil?
      lab = load_lab(ucl)
      if lab.save
        flash[:success] = 'Lab/group added'
        user.lab_groups << lab
        user.save
        ucl.destroy
      else
        flash[:error] = 'An error occurred'
      end
    end
    respond_to do |format|
      format.js { render partial: 'shared/add_success' }
      format.html
    end
  end

  def edit
  end

  def update
  end

  def destroy
    UserCustomLabgroup.find(lab_params[:lab_id]).destroy
  end

  private 

    def load_lab(ucl)
      location = add_location(ucl)
      LabGroup.create(
        name: ucl.custom_labgroup_name,
        code: ucl.custom_labgroup_code,
        location_id: location.id
      )
    end


    def add_location(ucl)
      address = add_address(ucl)
      Location.create(
        building: ucl.custom_labgroup_building,
        room: ucl.custom_labgroup_room,
        address_id: address.id
      )
    end

    def lab_params
      params.permit(:lab_id)
    end
end
