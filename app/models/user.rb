class User < ApplicationRecord
  ADMIN_EMAIL = 'admin@depot.com'

  validates :name, :email, presence: true, uniqueness: true
  validates :email, allow_blank: true, format: { 
    with: VALID_EMAIL_REGEX,
		message: 'is not an email' 
  }
  
  has_secure_password

  after_create_commit :notify_with_welcome_email
  before_update :ensure_user_is_not_admin_before_update
  before_destroy :ensure_user_is_not_admin_before_destroy
  after_destroy :ensure_an_admin_remains

  has_many :orders, dependent: :restrict_with_error
  has_many :line_items, through: :orders
  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address
  has_many :counters, dependent: :destroy

  class Error < StandardError
  end

  def set_last_activity
    self.last_activity_time = Time.current
    self.save
  end

  private
  def ensure_an_admin_remains
    if User.count.zero?
      raise Error.new "Can't delete last User"
    end
  end

  def ensure_user_is_not_admin_before_update
    if email.eql?(ADMIN_EMAIL)
      errors.add(:email, 'can\'t update admin')
      throw :abort 
    end
  end

  def ensure_user_is_not_admin_before_destroy
    if email.eql?(ADMIN_EMAIL)
      errors.add(:email, 'can\'t delete admin')
      throw :abort 
    end
  end
  
  def notify_with_welcome_email
    UserMailer.created(self).deliver_later
  end
end
