class CommitteesController < ApplicationController
  load_and_authorize_resource

  def index
    @committees = Committee.all
  end

  def new
    @proposal = Proposal.find(params[:proposal_id])
    @committee = Committee.new
    @faculty = User.filter_roles(2)
    @advisors = User.filter_roles(4)
  end

  def create
    @committee = Committee.new(committee_params)
    @proposal = Proposal.find(params[:proposal_id])
    @committee.proposal = @proposal
    members = load_committee_members(member_params[:faculty], member_params[:advisors])
    members.each do |member|
      @committee.users << User.find(member)
    end

    if @committee.save
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
  end

  def destroy
    Committee.find(params[:id]).destroy
  end

  private
    def committee_params
      params.require(:committee).permit(:deadline)
    end

    def member_params
      params.permit(
        faculty:[], advisors:[]
      )
    end

    def load_committee_members(faculty, advisors)
      (faculty + advisors).uniq if faculty && advisors
    end
end
