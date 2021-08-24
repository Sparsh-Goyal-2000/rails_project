class ComparePriceValidator < ActiveModel::Validator
  PRICE_ERROR_MESSAGE = 'must be greater than discount price'

  def validate(record)
    return if record.price.nil? || record.discount_price.nil?

    if record.price < record.discount_price
      record.errors.add :price, PRICE_ERROR_MESSAGE
    end
  end
end