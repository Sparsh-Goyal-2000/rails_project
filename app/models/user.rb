class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  ADMIN_EMAIL = 'admin@depot.com'

  validates :name, presence: true, uniqueness: true
  validates :email, uniqueness: true, format: { 
    with: VALID_EMAIL_REGEX,
		message: 'is not an email' 
  }
  
  has_secure_password

  after_create_commit :notify_with_welcome_email, if: :email?
  before_update :ensure_user_is_not_admin_before_update
  before_destroy :ensure_user_is_not_admin_before_destroy
  after_destroy :ensure_an_admin_remains

  has_many :orders
  has_many :line_items, through: :orders

  class Error < StandardError
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
