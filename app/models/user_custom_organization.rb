class UserCustomOrganization < ActiveRecord::Base
  belongs_to :user
  belongs_to :state
end
