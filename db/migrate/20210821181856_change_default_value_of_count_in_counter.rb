class ChangeDefaultValueOfCountInCounter < ActiveRecord::Migration[6.1]
  def change
    change_column_default :counters, :count, from: nil, to: 0
  end
end
