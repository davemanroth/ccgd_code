class Address < ActiveRecord::Base
  belongs_to :state
  has_one :location
  has_many :organizations
end
