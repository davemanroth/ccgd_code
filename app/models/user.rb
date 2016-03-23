class User < ActiveRecord::Base
  validates :username, presence: true 
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true
  # validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :organization_id, presence: true
  validates :location_id, presence: true
  belongs_to :location
  belongs_to :organization
  has_many :memberships
  has_many :lab_groups, through: :memberships
  has_many :privileges
  has_many :roles, through: :privileges
  has_secure_password
end
