class Organization < ActiveRecord::Base
  belongs_to :address
  has_one :user
  validates :name, presence: true
  validates :address_id, presence: true
end
