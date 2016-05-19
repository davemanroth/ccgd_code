class ProposalPlatform < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :platform
end
