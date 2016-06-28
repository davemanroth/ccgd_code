class MemberVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :committee
  belongs_to :vote
end
