class AddColumnsToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :enabled, :boolean
    add_column :products, :discount_price, :decimal, precision: 7, scale: 2
    add_column :products, :permalink, :string
  end
end
