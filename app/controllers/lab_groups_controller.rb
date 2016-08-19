class LabGroupsController < ApplicationController
  include AddressHelper
  load_and_authorize_resource except: [:new, :create]

  def index
    @labgroups = LabGroup.all
    render layout: false if params[:rendering]
  end

  def new
    @labgroup = LabGroup.new
  end

  def create
    if params[:form_type] == 'admin'
      @labgroup = LabGroup.new(admin_labgroup_params)
      if @labgroup.save
        flash[:success] = "New labgroup successfully added"
        redirect_to configurations_path
      else
        flash[:error] = "Error saving labgroup"
        render "new"
      end
    else
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
  end

  def edit
    @labgroup = LabGroup.find(params[:id])
  end

  def update
    @labgroup = LabGroup.find(params[:id])
    if @labgroup.update_attributes(admin_labgroup_params)
      flash[:success] = "Labgroup successfully updated"
      redirect_to configurations_path
    else
      flash[:error] = "Error updating labgroup"
      render "edit"
    end
  end

  def destroy
    if lab_params[:lab_id]
      UserCustomLabgroup.find(lab_params[:lab_id]).destroy
    else
      LabGroup.find(params[:id]).destroy
      respond_to do |f|
        f.html { redirect_to configurations_path, status: 303 }
      end
    end
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

    def admin_labgroup_params
      params.require(:lab_group).permit(
        :name, :code, :location_id
      )
    end
end
