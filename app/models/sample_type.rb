class SampleType < ActiveRecord::Base
  validates :name, presence: true 
  has_many :proposal_sample_types
  has_many :proposals, :through => :proposal_sample_types
end
