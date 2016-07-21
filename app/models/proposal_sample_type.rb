class ProposalSampleType < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :sample_type
end
