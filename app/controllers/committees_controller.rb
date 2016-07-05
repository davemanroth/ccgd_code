class CommitteesController < ApplicationController

  def index
    @committees = Committee.all
  end

  def new
    @proposal = Proposal.find(params[:proposal_id])
    @committee = Committee.new
  end

  def create
    @committee = Committee.new(committee_params)
    members = load_committee_members(member_params[:faculty], member_params[:advisors])
    members.each do |member|
      @committee.users << User.find(member)
    end

    if @committee.save
      flash[:success] = "Committee saved"
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
      params.require(:committee).permit(
        :proposal_id, :deadline 
      )
    end

    def member_params
      params.require(:committee).permit(
        faculty:[], advisors:[]
      )
    end

    def load_committee_members(faculty, advisors)
      (faculty + advisors).uniq if faculty && advisors
    end
end
