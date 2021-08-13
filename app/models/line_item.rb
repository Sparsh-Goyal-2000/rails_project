class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product, optional: true
  belongs_to :cart, counter_cache: :line_items_count

  validates :cart_id, allow_nil: true, uniqueness: {
    scope: :product_id,
		message: 'one product can be added only once in the cart' 
  }

  def total_price
    product.price*quantity
  end
end
