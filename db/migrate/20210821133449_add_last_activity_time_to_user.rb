class AddLastActivityTimeToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :last_activity_time, :time
  end
end
