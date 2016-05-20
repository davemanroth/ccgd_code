class ProposalsController < ApplicationController
  def index
    @proposals = Proposal.all
  end

  def show
    @proposal = Proposal.find(params[:id])
  end

  def new
    @proposal = Proposal.new
  end

  def create
    @proposal = Proposal.new(proposal_params)
=begin
=end
    platform_params[:platforms].each do |val|
      @proposal.platforms << Platform.find(val)
    end

    if @proposal.save
      flash[:success] = "Proposal saved"
    else
      flash[:error] = "Error saving proposal"
    end
  end

  def edit
    @proposal = Proposal.find(params[:id])
  end

  def update
    @proposal = Proposal.find(params[:id])
    if @proposal.update_attributes(proposal_params)
      flash[:success] = "Proposal saved"
    else
      flash[:error] = "Error updating proposal"
    end
  end

  def destroy
    Proposal.find(params[:id]).destroy
  end

  private
    def proposal_params
      params.require(:proposal).permit(
        :name, :objectives, :background,
        :design_details, :sample_availability,
        :contributions, :comments, :financial_contact,
        :billing_dept, :billing_street, :billing_building,
        :billing_room, :billing_city, :billing_zip, 
        :billing_email, :billing_phone, :state_id,
        :user_id, :lab_group_id, :ccgd_policy
      )
    end

    def platform_params
      params.require(:proposal).permit(platforms:[])
    end
=begin
=end
end
