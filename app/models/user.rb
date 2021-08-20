class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  
  validates :name, :email, presence: true, uniqueness: true
  validates :email, allow_blank: true, format: { 
    with: VALID_EMAIL_REGEX,
		message: 'is not an email' 
  }
  
  has_secure_password

  after_destroy :ensure_an_admin_remains

  class Error < StandardError
  end

  private
  def ensure_an_admin_remains
    if User.count.zero?
      raise Error.new "Can't delete last User"
    end
  end
end
