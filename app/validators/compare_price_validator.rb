class ComparePriceValidator < ActiveModel::Validator
  PRICE_ERROR_MESSAGE = 'must be greater than discount price'

  def validate
    return if price.nil? || discount_price.nil?

    unless price > discount_price
      errors.add :price, PRICE_ERROR_MESSAGE
    end
  end
end