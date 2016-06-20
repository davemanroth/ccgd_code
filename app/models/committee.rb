class Committee < ActiveRecord::Base
  belongs_to :proposal
  has_many :users
  has_many :users, :through => :committee_members
end
