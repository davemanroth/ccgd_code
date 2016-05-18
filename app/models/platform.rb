class Platform < ActiveRecord::Base
  has_many :proposal_platforms
  has_many :proposals, through: :proposal_platforms
end
