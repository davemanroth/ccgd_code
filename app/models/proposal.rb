class Proposal < ActiveRecord::Base

  belongs_to :user
  belongs_to :state
  belongs_to :proposal_status
  belongs_to :lab_group
  has_many :proposal_platforms
  has_many :platforms, :through => :proposal_platforms
  validates :name, presence: true 
  validates :objectives, presence: true 
  validates :design_details, presence: true 
  validates :user_id, presence: true 
  validates :lab_group_id, presence: true 
  validates :ccgd_policy_approval, presence: true, :if => :should_policy_be_accepted?
  attr_accessor :policy_should_be_accepted

  def generate_code
    num = 1000 + self.id
    self.code = ['S', self.platforms.first.code, num].join('')
  end

  private

    def submitted?
      self.submitted
    end

    def should_policy_be_accepted?
      policy_should_be_accepted
    end

end
