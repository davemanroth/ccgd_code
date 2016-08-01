class Proposal < ActiveRecord::Base

  scope :non_draft, -> { where(proposal_status: (2..7) ).order(name: :asc) }
  scope :pending, -> { where(proposal_status: (2) ).order(name: :asc) }

  belongs_to :user
  belongs_to :state
  belongs_to :proposal_status
  belongs_to :lab_group
  has_one :committee
  has_many :proposal_sample_types
  has_many :sample_types, :through => :proposal_sample_types
  has_many :proposal_platforms
  has_many :platforms, :through => :proposal_platforms
  accepts_nested_attributes_for :sample_types, allow_destroy: true
  validates :name, presence: true 
  validates :objectives, presence: true 
  validates :design_details, presence: true 
  validates :user_id, presence: true 
  validates :lab_group_id, presence: true 
  validates :ccgd_policy_approval, presence: true, :if => :should_policy_be_accepted?, inclusion: { in: [true, false], message: 'You must accept the CCGD policy' }
  attr_accessor :policy_should_be_accepted

# 1 - Draft/private proposal,draft
# 2 - Pending review,pending
# 3 - Under committee review,review
# 4 - Accepted/project initiated,accepted
# 5 - Rejected,rejected
# 6 - Abandoned,abandoned
# 7 - Complete/deprecated,complete
# 8 - Awaiting revision, revision

  def generate_code
    num = 1000 + self.id
    self.code = ['S', self.platforms.first.code, num].join('')
  end

  def is_pending?
    self.proposal_status.id == 2
  end

  def is_complete?
    self.proposal_status.id == 7
  end

  private

    def submitted?
      self.submitted
    end

    def should_policy_be_accepted?
      policy_should_be_accepted
    end

end
