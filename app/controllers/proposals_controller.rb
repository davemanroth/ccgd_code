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
  end

  def edit
    @proposal = Proposal.find(params[:id])
  end

  def update
    @proposal = Proposal.find(params[:id])
  end

  def destroy
    @proposal = Proposal.find(params[:id])
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
        :platform_id, :user_id, :lab_group_id,
        :ccgd_polcy
      )
    end
end
