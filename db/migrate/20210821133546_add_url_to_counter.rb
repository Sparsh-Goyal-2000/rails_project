class AddUrlToCounter < ActiveRecord::Migration[6.1]
  def change
    add_column :counters, :url, :string
  end
end
