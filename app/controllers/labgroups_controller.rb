class LabgroupsController < ApplicationController
  include AddressHelper

  def create
    ucl = UserCustomLabgroup.find(lab_params[:lab_id])
    if !ucl.nil?
      lab = load_lab(ucl)
      if lab.save
        flash[:success] = 'Lab/group added'
      else
        flash[:error] = 'An error occurred'
      end
    end
  end

  private 

    def load_lab(ucl)
      location = add_location(ucl)
      Labgroup.create(
        name: ucl.custom_labgroup_name,
        code: ucl.custom_labgroup_phone,
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
