require_relative '../validators/url_validator'
require_relative '../validators/compare_price_validator'

class Product < ApplicationRecord

  VALID_PERMALINK_REGEX = /\A([[:alnum:]]+-){2,}([[:alnum:]]+)\z/
  VALID_DESCRIPTION_REGEX = /\A(\s*\w+\s+){4,9}(\s*\w+\s*)\z/
  MINIMUM_PRICE = 0.01
  PERMALINK_ERROR_MESSAGE = 'should have minimum 3 words separated by hyphen'
  DESCRIPTION_ERROR_MESSAGE = 'should be between 5 to 10 words'
  LINE_ITEMS_PRESENT_MESSAGE = 'Line Items present'
  DEFAULT_TITLE = 'abc'

  validates :title, presence: true, uniqueness: true
  validates :description, allow_blank: true, format: {
    with: VALID_DESCRIPTION_REGEX,
    message: DESCRIPTION_ERROR_MESSAGE
  }
  validates :image_url, allow_blank: true, url: true
  validates :price, presence: true, numericality: { 
    greater_than_or_equal_to: MINIMUM_PRICE,
    only_integer: true
  }

  # Using Custom Validator
   validates_with ComparePriceValidator

  # Without using Custom Validator
  validates :price, numericality: { 
    greater_than: :discount_price
  }, if: :discount_price

  validates :permalink, uniqueness: true, allow_blank: true, format: {
    with: VALID_PERMALINK_REGEX,
    message: PERMALINK_ERROR_MESSAGE
  }

  has_many :line_items
  has_many :orders, through: :line_items

  before_destroy :ensure_not_referenced_by_any_line_item
  after_initialize :set_defaults

  private

  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, LINE_ITEMS_PRESENT_MESSAGE)
      throw :abort
    end
  end
  def set_defaults
<<<<<<< HEAD
    self.title = DEFAULT_TITLE unless title
=======
    self.title = 'abc' unless title
>>>>>>> callbacks commit
    self.discount_price = price unless discount_price
  end  
end