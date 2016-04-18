class Location < ActiveRecord::Base
  belongs_to :address
  has_many :lab_groups
  validates :building, presence: true
  validates :address_id, presence: true

  def building_room
    [building, room].join(', ')
  end
end
