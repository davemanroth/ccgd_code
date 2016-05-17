class Proposal < ActiveRecord::Base
  belongs_to :user
  belongs_to :state
  belongs_to :proposal_status
  belongs_to :platform
  belongs_to :lab_group
  validates :name, presence: true 
  validates :objectives, presence: true 
  validates :design_details, presence: true 
  validates :platform_id, presence: true 
  validates :user_id, presence: true 
  validates :lab_group_id, presence: true 

  after_create :generate_code

  private
    def generate_code
      num = 1000 + self.id
      self.code = ['S', self.platform.code, num].join('')
    end

end
