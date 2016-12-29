class CommitteesController < ApplicationController
  load_and_authorize_resource

  def index
    @committees = Committee.all
  end

  def new
    @proposal = Proposal.find(params[:proposal_id])
    if @proposal.committee
      flash[:error] = "Committee already created for this proposal"
      redirect_to proposals_path 
    else
      @committee = Committee.new
      @faculty = User.filter_roles(2)
      @advisors = User.filter_roles(4)
    end
  end

  def create
    @committee = Committee.new(committee_params)
    @proposal = Proposal.find(params[:proposal_id])
    @committee.proposal = @proposal

# Force a proposal status updated to "Under committee review" when a committee is formed
    update_status(@proposal, 3)
    load_committee_members(@committee, member_params[:faculty], member_params[:advisors])

    if @committee.save
      UserMailer.committee_member(@committee).deliver_now
      flash[:success] = "Committee saved"
      redirect_to edit_proposal_committee_path(@proposal, @committee)
    else
      flash[:error] = "Error saving committee"
      render 'new'
    end

  end

  def show
  end

  def edit
    @proposal = Proposal.find(params[:proposal_id])
    @committee = Committee.find(params[:id])
    @faculty = User.filter_roles(2)
    @advisors = User.filter_roles(4)
  end

  def update
    @proposal = Proposal.find(params[:proposal_id])
    @committee = Committee.find(params[:id])
    status = status_params[:status]
    update_status(@proposal, status)
    #if status == 8
      
    load_committee_members(@committee, member_params[:faculty], member_params[:advisors])

    if @committee.update_attributes(committee_params)
      flash[:success] = "Committee successfully updated"
      redirect_to edit_proposal_committee_path(@proposal, @committee)
    else
      flash[:error] = "There was a problem updating this committee"
      render 'edit'
    end
  end

  def destroy
    Committee.find(params[:id]).destroy
  end

  private
    def committee_params
      params.require(:committee).permit(:deadline)
    end

    def status_params
      params.permit(:status)
    end

    def member_params
      params.permit(
        faculty:[], advisors:[]
      )
    end

    def update_status(prop, status_id)
      status = ProposalStatus.find(status_id) 
      prop.update(proposal_status: status)
      if status_id == 8
        remove_committee_and_votes(@proposal)
      end
    end

    def load_committee_members(comm, faculty, advisors)
      comm.member_votes.clear
      members = { 2 => faculty, 4 => advisors }
      members.each do |role_id, group|
        unless group.nil?
          group.each do |user_id|
            mv = MemberVote.create(
              user: User.find(user_id),
              member_role: role_id,
              committee: comm
            )
            comm.member_votes << mv
          end
        end
      end
      #binding.pry
    end
end
