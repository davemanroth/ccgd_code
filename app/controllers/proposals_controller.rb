class ProposalsController < ApplicationController
  load_and_authorize_resource

  def index
    if current_user.has_multiple_roles? or current_user.is_admin? or current_user.is_staff?
      @proposals = Proposal.non_draft
    elsif current_user.is_only_faculty_or_advisor?
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
    manage_platforms(@proposal)
    manage_sample_types(@proposal)

    @proposal.proposal_status = ProposalStatus.find(1)

    if params[:submit_proposal]
      @proposal.policy_should_be_accepted = true
      @proposal.submitted = true
    end

    if @proposal.save
      if params[:submit_proposal]
        @proposal.update( proposal_status: ProposalStatus.find(2) )
=begin
=end
        AdminMailer.new_proposal(@proposal).deliver_now
        flash[:success] = "Proposal submitted"
      else
        flash[:success] = "Proposal saved"
      end
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
    manage_platforms(@proposal)
    manage_sample_types(@proposal)

    if params[:submit_proposal]
      @proposal.submitted = true
      @proposal.policy_should_be_accepted = true
    end

    if @proposal.update_attributes(proposal_params)
      if params[:submit_proposal]
        @proposal.update( proposal_status: ProposalStatus.find(2) )
=begin
=end
        AdminMailer.new_proposal(@proposal).deliver_now
        flash[:success] = "Proposal submitted"
        redirect_to user_path(@proposal.user_id)
      elsif params[:update_proposal]
        flash[:success] = "Proposal updated"
        redirect_to proposals_path
      else
        flash[:success] = "Proposal saved"
        redirect_to user_path(@proposal.user_id)
      end
    else
      flash[:error] = "Error saving proposal"
      render 'edit'
    end
  end

  def destroy
    @proposal = Proposal.find(params[:id])
    Proposal.find(@proposal).destroy
    respond_to do |f|
      f.html { redirect_to user_path(@proposal.user_id) }
      flash[:success] = "Proposal successfully deleted"
    end
  end

  def proposal_status_update
    @proposal = Proposal.find(params[:id])
    old_status = @proposal.proposal_status.id
    new_status = params[:status].to_i

    # Generate the proposal code if the proposal was submitted by the user 
    # and approved by the admin
    if should_generate_code?(old_status, new_status, @proposal)
      @proposal.generate_code
    end

    # Update the proposal status regardless
    @proposal.proposal_status = ProposalStatus.find(new_status)
    if new_status == 8
      remove_committee_and_votes(@proposal)
    end

    if @proposal.save
      # do something
    else
      flash[:error] = 'Error updating proposal status'
    end
  end


  private
    def proposal_params
      params.require(:proposal).permit(
        :name, :user_id, :objectives, :background,
        :design_details, :sample_availability,
        :contributions, :comments, :lab_group_id, 
        :ccgd_policy_approval
      )
    end

    def platform_params
      params.require(:proposal).permit(platforms:[])
    end


    def sample_type_params
      params.require(:proposal).permit(sample_types:[])
    end

    def new_sample_type_params
      params.require(:proposal).permit(
        sample_type: [:name]
      )
    end

    def is_legit_status?(status)
      statuses = [2, 3, 5, 6, 8]
      statuses.include?(status)
    end

    def should_generate_code?(old_status, new_status, proposal)
      is_legit_status?(old_status) and new_status == 4 and proposal.code.nil?
    end

    def add_sample_types_to_proposal(prop, sample_types)
      sample_types.each do |st|
        prop.sample_types << SampleType.find(st)
      end
    end

    def manage_platforms(proposal)
      proposal.platforms.clear if !proposal.platforms.empty?
      platform_params[:platforms].each do |val|
        proposal.platforms << Platform.find(val) unless val.empty?
      end
    end

    def manage_sample_types(proposal)
      proposal.sample_types.clear if !proposal.sample_types.empty?
      sample_types = sample_type_params[:sample_types].drop(1) || []
      if !new_sample_type_params[:sample_type][:name].empty?
        new_sample_type = new_sample_type_params[:sample_type][:name]
        new_sample = add_new_sample_type(new_sample_type)
        sample_types << new_sample.id
      end
      add_sample_types_to_proposal(@proposal, sample_types) unless sample_types.empty?
    end

    def add_new_sample_type(new_sample)
      SampleType.create(name: new_sample)
    end
end
