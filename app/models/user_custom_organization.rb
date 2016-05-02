class UserCustomOrganization < ActiveRecord::Base
  has_one :user
  belongs_to :state
end
