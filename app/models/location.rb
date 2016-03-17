class Location < ActiveRecord::Base
  belongs_to :address
  has_many :lab_groups
end
