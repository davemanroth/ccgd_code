class MemberVotesController < ApplicationController
  load_and_authorize_resource
  def new
    @member_vote = MemberVote.new
  end

  def create
  end

  def edit
  end

  def update
  end
end
