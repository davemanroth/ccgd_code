class ProposalsController < ApplicationController
  load_and_authorize_resource

  def index
    if can? :manage, Proposal
      @proposals = Proposal.non_draft
    elsif can? :vote, Proposal
      @proposals = Proposal.joins(committee: :member_votes).where(member_votes: { user_id: current_user })
    else
    end
  end

  def show
    @proposal = Proposal.find(params[:id])
  end

  def new
    @proposal = Proposal.new
  end

  def create
    @proposal = Proposal.new(proposal_params)
    # binding.pry
    manage_sample_types(@proposal)
=begin
=end

    @proposal.user_id = current_user.id
    @proposal.proposal_status = ProposalStatus.find(1)

    platform_params[:platforms].each do |val|
      @proposal.platforms << Platform.find(val) unless val.empty?
    end

    if params[:submit_proposal]
      @proposal.policy_should_be_accepted = true
      @proposal.proposal_status = ProposalStatus.find(2)
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
    manage_sample_types(@proposal)

    if params[:submit_proposal]
      @proposal.submitted = true
      @proposal.policy_should_be_accepted = true
      @proposal.proposal_status = ProposalStatus.find(2)
    end

    if @proposal.update_attributes(proposal_params)
      flash[:success] = "Proposal saved"
      redirect_to user_path(@proposal.user_id)
    else
      flash[:error] = "Error saving proposal"
      render 'edit'
    end
  end

  def destroy
    Proposal.find(params[:id]).destroy
  end

  def proposal_status_update
    @proposal = Proposal.find(params[:id])
    @proposal.proposal_status = ProposalStatus.find(params[:status])
    if @proposal.save
      # do something
    else
      flash[:error] = 'Error updating proposal status'
    end
  end


  private
    def proposal_params
      params.require(:proposal).permit(
        :name, :objectives, :background,
        :design_details, :sample_availability,
        :contributions, :comments, :lab_group_id, 
        :ccgd_policy_approval
      )
    end

    def platform_params
      params.require(:proposal).permit(platforms:[])
    end

    def manage_sample_types(proposal)
      sample_types = sample_type_params.drop(1) || []
      if !new_sample_type_params.empty?
        add_new_sample_type(new_sample_type_params)
        sample_types << new_sample_type_params
      end
      add_sample_types_to_proposal(@proposal, sample_types) unless sample_types.empty?
    end

    def sample_type_params
      params.require(:proposal).permit(sample_types:[])
    end

    def new_sample_type_params
      params.require(:proposal).permit(:new_sample_type)
    end

    def add_sample_types_to_proposal(prop, sample_types)
      sample_types.each do |st|
        prop.sample_types << SampleType.find_by(name: st)
      end
    end

    def add_new_sample_type(new_sample)
      SampleType.create(name: new_sample)
    end
=begin
=end
end
