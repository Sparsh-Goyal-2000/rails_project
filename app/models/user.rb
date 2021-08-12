class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  
  validates :name, presence: true, uniqueness: true
  validates :email, uniqueness: true, format: { 
    with: VALID_EMAIL_REGEX,
		message: 'is not an email' 
  }
  
  has_secure_password

  after_create :notify_with_welcome_email, if: :email?
  before_update :check_admin
  before_destroy :check_admin
  after_destroy :ensure_an_admin_remains

  class Error < StandardError
  end

  private
  def ensure_an_admin_remains
    if User.count.zero?
      raise Error.new "Can't delete last User"
    end
  end

  def check_admin
    if email.eql?('admin@depot.com')
      errors.add(:email, 'can\'t delete or update admin')
      throw :abort 
    end
  end

  def notify_with_welcome_email
    UserMailer.created(self).deliver
  end
end
