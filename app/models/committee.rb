class Committee < ActiveRecord::Base
  belongs_to :proposal
  has_many :committee_members
  has_many :users, :through => :committee_members
end
