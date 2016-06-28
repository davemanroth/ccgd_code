class CommitteesController < ApplicationController

  def index
    @committees = Committee.all
  end

  def new
    @proposal = Proposal.find(params[:proposal_id])
    @committee = Committee.new
  end

  def create
  end

  def show
  end

  def edit
    @proposal = Proposal.find(params[:proposal_id])
    @committee = Committee.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private
    def committee_params
      params.require(:committee).permit()
    end
end
