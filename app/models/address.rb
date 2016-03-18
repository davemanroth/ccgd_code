class Address < ActiveRecord::Base
  belongs_to :state
  has_one :location
  has_many :organizations
  validates :street, presence: true
  validates :city, presence: true
end
