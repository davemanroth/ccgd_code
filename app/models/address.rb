class Address < ActiveRecord::Base
  belongs_to :state
  has_one :location
  has_many :organizations
  validates :street, presence: true

  def full_address
    address = [street, city]
    if state_id and state_id != 0
      state = State.find(state_id).code
      address << state
    end
    address << country if country != 'NULL'
    address.join(', ')
  end
end
