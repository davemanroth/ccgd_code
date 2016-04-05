class User < ActiveRecord::Base

  scope :pending, -> { where(status: 'P').order(lastname: :asc) }
  scope :approved, -> { where(status: 'A').order(lastname: :asc) }

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
  has_many :roles, :through => :privileges
  has_secure_password

  after_create { self.status = 'P' }

  def full_name
    [firstname.downcase.capitalize, lastname.downcase.capitalize].join(' ')
  end

  def all_roles
    roles = ''
    self.roles.each_with_index do |role, i|
      roles += role.description
      comma = i == self.roles.size - 1 ? '' : ', ' 
      roles += comma
    end
    roles
  end

end
