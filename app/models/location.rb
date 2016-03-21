class Location < ActiveRecord::Base
  belongs_to :address
  has_one :user
  has_many :lab_groups
  validates :building, presence: true
  validates :address_id, presence: true
end
