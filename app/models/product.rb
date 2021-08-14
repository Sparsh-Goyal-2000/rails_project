require_relative '../validators/url_validator'
require_relative '../validators/compare_price_validator'

class Product < ApplicationRecord

  VALID_PERMALINK_REGEX = /\A([a-zA-Z0-9]+-){2,}([a-zA-Z0-9]+)\z/
  VALID_DESCRIPTION_REGEX = /\A(\s*\w+\s+){4,9}(\s*\w+\s*)\z/
  MINIMUM_PRICE = 0.01
  PERMALINK_ERROR_MESSAGE = 'should have minimum 3 words separated by hyphen'
  DESCRIPTION_ERROR_MESSAGE = 'should be between 5 to 10 words'
  LINE_ITEMS_PRESENT_MESSAGE = 'Line Items present'

  validates :title, presence: true, uniqueness: true
  validates :description, allow_blank: true, format: {
    with: VALID_DESCRIPTION_REGEX,
    message: DESCRIPTION_ERROR_MESSAGE
  }
  validates :image_url, allow_blank: true, url: true
  # Using Custom Validator
  validates_with ComparePriceValidator

  # Without using Custom Validator
  validates :price, presence: true
  validates :price, numericality: { 
    greater_than_or_equal_to: MINIMUM_PRICE,
    greater_than: :discount_price,
    only_integer: true
  }, if: :discount_price
  validates :permalink, uniqueness: true, allow_blank: true, format: {
    with: VALID_PERMALINK_REGEX,
    message: PERMALINK_ERROR_MESSAGE
  }

  has_many :line_items
  has_many :orders, through: :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  private

  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, LINE_ITEMS_PRESENT_MESSAGE)
      throw :abort
    end
  end
end