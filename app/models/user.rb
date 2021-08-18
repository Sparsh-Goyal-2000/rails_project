class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  ADMIN_EMAIL = 'admin@depot.com'

  validates :name, presence: true, uniqueness: true
  validates :email, uniqueness: true, format: { 
    with: VALID_EMAIL_REGEX,
		message: 'is not an email' 
  }
  
  has_secure_password

<<<<<<< HEAD
<<<<<<< HEAD
  after_create_commit :notify_with_welcome_email, if: :email?
  before_update :check_admin_while_update
  before_destroy :check_admin_while_destroy
=======
  after_create :notify_with_welcome_email, if: :email?
  before_update :check_admin
  before_destroy :check_admin
>>>>>>> callbacks commit
=======
  after_create_commit :notify_with_welcome_email, if: :email?
  before_update :check_user_before_update
  before_destroy :check_user_before_destroy
>>>>>>> 97ef305807feac1c09d40f3d23d8f9305270caaf
  after_destroy :ensure_an_admin_remains

  class Error < StandardError
  end

  private
  def ensure_an_admin_remains
    if User.count.zero?
      raise Error.new "Can't delete last User"
    end
  end

<<<<<<< HEAD
<<<<<<< HEAD
  def check_admin_while_update
=======
  def check_user_before_update
>>>>>>> 97ef305807feac1c09d40f3d23d8f9305270caaf
    if email.eql?(ADMIN_EMAIL)
      errors.add(:email, 'can\'t update admin')
      throw :abort 
    end
  end

<<<<<<< HEAD
  def check_admin_while_destroy
    if email.eql?(ADMIN_EMAIL)
      errors.add(:email, 'can\'t delete admin')
=======
  def check_admin
    if email.eql?('admin@depot.com')
      errors.add(:email, 'can\'t delete or update admin')
>>>>>>> callbacks commit
=======
  def check_user_before_destroy
    if email.eql?(ADMIN_EMAIL)
      errors.add(:email, 'can\'t delete admin')
>>>>>>> 97ef305807feac1c09d40f3d23d8f9305270caaf
      throw :abort 
    end
  end

  def notify_with_welcome_email
<<<<<<< HEAD
<<<<<<< HEAD
    UserMailer.created(self).deliver_later
=======
    UserMailer.created(self).deliver
>>>>>>> callbacks commit
=======
    UserMailer.created(self).deliver_later
>>>>>>> 97ef305807feac1c09d40f3d23d8f9305270caaf
  end
end
