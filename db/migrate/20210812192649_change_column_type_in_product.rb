class ChangeColumnTypeInProduct < ActiveRecord::Migration[6.1]
  def up
    change_column :products, :price, :integer
  end

  def down
    change_column :products, :price, :string
  end
end
