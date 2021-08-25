class ChangeDefaultPriceInProduct < ActiveRecord::Migration[6.1]
  def up
    change_column_default :products, :price, nil
  end
end
