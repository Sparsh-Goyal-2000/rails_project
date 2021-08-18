class ChangeColumnInCatagory < ActiveRecord::Migration[6.1]
  def change
    rename_column :catagories, :count, :products_count
  end
end
