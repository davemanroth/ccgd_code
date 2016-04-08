class User < ActiveRecord::Base

  scope :pending, -> { where(status: 'P').order(lastname: :asc) }
  scope :approved, -> { where(status: 'A').order(lastname: :asc) }
  scope :non_inactive, -> { where(status: ['A', 'P']).order(lastname: :asc) }

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

  before_create :set_status

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

  def role_ids
    ids = []
    self.roles.each do |role|
      ids.push(role.id)
    end
    ids
  end

  def set_status
    self.status = 'P'
  end

  def status_name
    if !self.status.nil?
      names = { p: 'pending', i: 'inactive', a: 'active' }
      status = names[self.status.downcase.to_sym]
      status.capitalize
    end
  end

  def is_active?
    self.status == 'A'
  end

  def is_pending?
    self.status == 'P'
  end

end
