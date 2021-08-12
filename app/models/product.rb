require 'custom_validations'

class Product < ApplicationRecord
  include CustomValidations

  VALID_PERMALINK_REGEX = /\A(\w+-){2,}(\w+)\z/
  VALID_DESCRIPTION_REGEX = /\A( *\w+ +){4,9}( *\w+ *)\z/
  MINIMUM_PRICE = 0.01
  PERMALINK_ERROR_MESSAGE = 'should have minimum 3 words separated by hyphen'
  DESCRIPTION_ERROR_MESSAGE = 'should be between 5 to 10 words'
  LINE_ITEMS_PRESENT_MESSAGE = 'Line Items present'

  validates :title, :description, :image_url, :permalink, presence: true
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, url: true
  validates :permalink, uniqueness: true, allow_nil: true, format: {
    with: VALID_PERMALINK_REGEX,
    message: PERMALINK_ERROR_MESSAGE
  }
  validates :description, format: {
    with: VALID_DESCRIPTION_REGEX,
    message: DESCRIPTION_ERROR_MESSAGE
  }

  # Using Custom Validator
  validates_with ComparePriceValidator

  # Without using Custom Validator
  validates :price, allow_nil: true, numericality: { 
    greater_than_or_equal_to: MINIMUM_PRICE,
    greater_than: :discount_price,
    only_integer: true
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