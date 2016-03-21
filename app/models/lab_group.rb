class LabGroup < ActiveRecord::Base
  validates :name, presence: true
  validates :location_id, presence: true
  belongs_to :location
  has_and_belongs_to_many :users
end
