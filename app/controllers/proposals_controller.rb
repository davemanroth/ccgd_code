class ProposalsController < ApplicationController
  load_and_authorize_resource

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
    @proposal.user_id = current_user.id
=begin
=end

    platform_params[:platforms].each do |val|
      @proposal.platforms << Platform.find(val) unless val.empty?
    end

    if params[:submit_proposal]
      @proposal.submitted = true
      @proposal.policy_should_be_accepted = true
      Rails.logger.debug(params)
    end

    if @proposal.save
      flash[:success] = "Proposal saved"
      redirect_to user_path(@proposal.user_id)
    else
      flash[:error] = "Error saving proposal"
      render 'new'
    end
  end

  def edit
    @proposal = Proposal.find(params[:id])
  end

  def update
    @proposal = Proposal.find(params[:id])

    if !params[:submitted].nil?
      @proposal.submitted = true
    end

    if @proposal.update_attributes(proposal_params)
      respond_to do |f|
        f.html
      end
      flash[:success] = "Proposal saved"
      redirect_to user_path(@proposal.user_id)
    else
      flash[:error] = "Error updating proposal"
      render 'edit'
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
        :lab_group_id, :ccgd_policy_approval
      )
    end

    def platform_params
      params.require(:proposal).permit(platforms:[])
    end
=begin
=end
end
