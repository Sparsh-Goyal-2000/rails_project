class Product < ApplicationRecord

  VALID_PERMALINK_REGEX = /\A([[:alnum:]]+-){2,}([[:alnum:]]+)\z/
  VALID_DESCRIPTION_REGEX = /\A(\s*\w+\s+){4,9}(\s*\w+\s*)\z/
  PERMALINK_ERROR_MESSAGE = 'should have minimum 3 words separated by hyphen'
  DESCRIPTION_ERROR_MESSAGE = 'should be between 5 to 10 words'
  LINE_ITEMS_PRESENT_MESSAGE = 'Line Items present'

  has_many :line_items, dependent: :restrict_with_error
  has_many :orders, through: :line_items
  has_many :carts, through: :line_items

  validates :title, :description, :price, presence: true
  with_options allow_blank: true do
    validates :title, uniqueness: true
    validates :description, format: {
      with: VALID_DESCRIPTION_REGEX,
      message: DESCRIPTION_ERROR_MESSAGE
    }
    validates :image_url, url: true
    validates :permalink, uniqueness: true, format: {
      with: VALID_PERMALINK_REGEX,
      message: PERMALINK_ERROR_MESSAGE
    }
  end
  
  # Using Custom Validator
  validates_with ComparePriceValidator

  with_options allow_nil: true do
    validates :price, numericality: { 
      greater_than_or_equal_to: MINIMUM_PRICE,
      only_integer: true
    }

    # Without using Custom Validator
    validates :price, numericality: { 
      greater_than: :discount_price
    }, if: :discount_price?
  end

  before_destroy :ensure_not_referenced_by_any_line_item
  after_initialize :set_title, unless: :title?
  before_validation :set_default_price, unless: :discount_price?

  scope :enabled, -> { where enabled: true }
  scope :disabled, -> { where enabled: false }

  private

  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, LINE_ITEMS_PRESENT_MESSAGE)
      throw :abort
    end
  end
  
  def set_title
    self.title = DEFAULT_TITLE 
  end

  def set_default_price
    self.discount_price = price
  end
end