class UserCustomLabgroupsController < ApplicationController
  def destroy
    UserCustomLabgroup.find(params[:id]).destroy
  end
end
