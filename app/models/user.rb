class User < ActiveRecord::Base

  scope :pending, -> { where(status: 'P').order(lastname: :asc) }
  scope :approved, -> { where(status: 'A').order(lastname: :asc) }
  scope :non_inactive, -> { where(status: ['A', 'P']).order(lastname: :asc) }

  validates :username, presence: true 
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true
  # validates :email, presence: true, uniqueness: { case_sensitive: false }
  belongs_to :organization
  has_one :user_custom_labgroup
  has_one :user_custom_organization
  accepts_nested_attributes_for :user_custom_labgroup, :user_custom_organization, allow_destroy: true
  has_many :memberships
  has_many :lab_groups, through: :memberships
  has_many :privileges
  has_many :roles, :through => :privileges
  has_many :committee_members
  has_many :committees, :through => :committee_members
  has_many :proposals
  has_secure_password

  before_create :initialize_user

  def self.filter_roles(role)
    users = []
    User.all.each do |u|
      users << u if u.role_ids.include?(role)
    end
    users
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver_now
  end

  def generate_token(col)
    begin
      self[col] = SecureRandom.urlsafe_base64
    end while User.exists?(col => self[col])
  end

  def self.all_statuses
    ['P', 'A', 'I']
  end

  def full_name
    [firstname, lastname].join(' ')
  end

  def org_attributes
    clean_attributes(self.user_custom_organization)
  end

  def lab_attributes
    clean_attributes(self.user_custom_labgroup)
  end

  def clean_attributes(custom_fields)
    if !custom_fields.nil?
      attrs = custom_fields.attributes.delete_if do |key, val|
        key.split('_').first != 'custom'
      end
      if !custom_fields.state_id.nil?
        attrs['state'] = State.find(custom_fields.state_id).code
      end
    end
    attrs.all? { |key, val| val.nil? } ? nil : attrs
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
