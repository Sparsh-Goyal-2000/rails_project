class ChangeEnabledToProduct < ActiveRecord::Migration[6.1]
  def change
    change_column_default :products, :enabled, false
  end
end
