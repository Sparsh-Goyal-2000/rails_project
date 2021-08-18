class ComparePriceValidator < ActiveModel::Validator
  PRICE_ERROR_MESSAGE = 'must be greater than discount price'
  INVALID_MESSAGE = 'is not a valid number'
  MINIMUM_PRICE = 0.01

  def validate(record)
    return if record.price.nil? || record.discount_price.nil?

    if record.price < MINIMUM_PRICE
      record.errors.add :price, INVALID_MESSAGE
    elsif record.price < record.discount_price
      record.errors.add :price, PRICE_ERROR_MESSAGE
    end
  end
end