class AddCatagoryRefToProduct < ActiveRecord::Migration[6.1]
  def change
    add_reference :products, :catagory, foreign_key: true
  end
end
