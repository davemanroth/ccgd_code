class Committee < ActiveRecord::Base
  belongs_to :proposal
  has_many :member_votes
  has_many :users, :through => :member_votes
  validates :proposal, presence: true
  validates :deadline, presence: true

  attr_accessor :faculty, :advisors

end
