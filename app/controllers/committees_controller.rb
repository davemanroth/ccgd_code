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
    load_committee_members(@committee, member_params[:faculty], member_params[:advisors])

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

    def member_params
      params.permit(
        faculty:[], advisors:[]
      )
    end

    def load_committee_members(comm, faculty, advisors)
      comm.member_votes.clear
      members = { 2 => faculty, 4 => advisors }
      members.each do |role_id, group|
        group.each do |user_id|
          mv = MemberVote.create(
            user: User.find(user_id),
            member_role: role_id,
            committee: comm
          )
          comm.member_votes << mv
        end
      end
      #binding.pry
=begin
      [faculty, advisors].each do |type|
        type.collect! { |num| num.to_i }
      end
      members = (faculty + advisors).uniq if faculty && advisors
      members.each do |member|
        comm.users << User.find(member)
      end
=end
    end
end
