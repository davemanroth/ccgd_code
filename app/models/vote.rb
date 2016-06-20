class Vote < ActiveRecord::Base
  has_one :committee_member
end
