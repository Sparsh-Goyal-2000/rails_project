require_relative '../validators/url_validator'
require_relative '../validators/compare_price_validator'

class Product < ApplicationRecord

  VALID_PERMALINK_REGEX = /\A([a-zA-Z0-9]+-){2,}([a-zA-Z0-9]+)\z/
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
  validate :check_if_catagory_exists
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

  has_many :line_items, dependent: :restrict_with_error
  has_many :orders, through: :line_items
  has_many :carts, through: :line_items
  belongs_to :catagory, counter_cache: :count

  before_destroy :ensure_not_referenced_by_any_line_item
  after_initialize :set_defaults
  after_create :increment_count

  scope :enabled, -> { where enabled: true }

  private

  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, LINE_ITEMS_PRESENT_MESSAGE)
      throw :abort
    end
  end
  def set_defaults
    self.title = DEFAULT_TITLE unless title
    self.discount_price = price unless discount_price
  end
  def check_if_catagory_exists
    if catagory_id.nil? || Catagory.find(catagory_id).nil?
      errors.add(:catagory, 'must exist')
    end
  end
  def increment_count
    catagory = Catagory.find(catagory_id)
    parent_catagory = Catagory.find(catagory.parent_id) if catagory.parent_id?
    catagory.count += 1
    parent_catagory.count += 1 unless parent_catagory.nil?
  end
end