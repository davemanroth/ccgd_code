class Proposal < ActiveRecord::Base
  belongs_to :user
  belongs_to :state
  belongs_to :proposal_status
  belongs_to :platform
  belongs_to :lab_group
end
