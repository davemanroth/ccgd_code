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
  validates :ccgd_policy, acceptance: { accept: 'yes' }, on: :create, allow_nil: false
  belongs_to :organization
  has_many :memberships
  has_many :lab_groups, through: :memberships
  has_many :privileges
  has_many :roles, :through => :privileges
  has_secure_password

  before_create :initialize_user

  def self.all_statuses
    ['P', 'A', 'I']
  end

  def full_name
    [firstname, lastname].join(' ')
  end

  def all_roles
    roles = ''
    self.roles.each_with_index do |role, i|
      roles += role.name
      comma = i == self.roles.size - 1 ? '' : ', ' 
      roles += comma
    end
    roles
  end

  def all_lab_groups
    self.lab_groups.pluck(:name)
  end

  def has_role?(id)
    self.role_ids.include?(id)
  end

  def initialize_user
    self.status = 'P'
    if Role.count > 0
      submitter = Role.find(5)
      self.roles << submitter
    end
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

  def is_inactive?
    self.status == 'I'
  end

end
