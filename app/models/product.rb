class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ %r{\.(gif|jpg|png)\Z}i
      record.errors.add(attribute, 'must be a URL for GIF, JPG or PNG image.')
    end
  end
end

class ComparePriceValidator < ActiveModel::Validator
  def validate(record)
    return if record.price.nil? || record.discount_price.nil?

    unless record.price > record.discount_price
      record.errors.add :price, "must be greater than discount price"
    end
  end
end

class Product < ApplicationRecord
  VALID_PERMALINK_REGEX = /\A([a-zA-Z]+-){2,}([a-zA-z]+)\z/
  VALID_DESCRIPTION_REGEX = /\A(\w+ ){4,9}(\w+)\z/

  validates :title, :description, :image_url, :permalink, presence: true
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, url: true
  validates :permalink, uniqueness: true, allow_nil: true, format: {
    with: VALID_PERMALINK_REGEX,
    message:  'should have minimum 3 words separated by hyphen'
  }
  validates :description, format: {
    with: VALID_DESCRIPTION_REGEX,
    message: 'should be between 5 to 10 words'
  }

  # Using Custom Validator
  include ActiveModel::Validations
  validates_with ComparePriceValidator

  # Without using Custom Validator
  validates :price, allow_nil: true, numericality: { 
    greater_than_or_equal_to: 0.01,
    greater_than: :discount_price,
    only_integer: true
  }

  has_many :line_items
  has_many :orders, through: :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  private

  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end
end