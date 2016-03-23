class LabGroup < ActiveRecord::Base
  validates :name, presence: true
  validates :location_id, presence: true
  belongs_to :location
  has_many :memberships
  has_many :users, through: :memberships
end
