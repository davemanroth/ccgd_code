class Organization < ActiveRecord::Base
  belongs_to :address
  validates :name, presence: true
  validates :address_id, presence: true
end
