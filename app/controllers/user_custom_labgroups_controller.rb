class UserCustomLabgroupsController < ApplicationController
  def destroy
    UserCustomLabgroup.find(params[:lab_id]).destroy
    respond_to do |format|
      format.js { render partial: 'shared/add_success' }
    end
  end
end
