class Privilege < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  # validates :user, :role, presence: true
end
