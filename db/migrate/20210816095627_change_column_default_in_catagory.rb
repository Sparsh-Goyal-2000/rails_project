class ChangeColumnDefaultInCatagory < ActiveRecord::Migration[6.1]
  def change
    change_column_default :catagories, :count, from: :null, to: 0
  end
end
