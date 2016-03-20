class LabGroup < ActiveRecord::Base
  validates :name, presence: true
  validates :code, presence: true
  validates :location_id, presence: true
  belongs_to :location
end
