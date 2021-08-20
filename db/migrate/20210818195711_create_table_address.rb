class CreateTableAddress < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :state
      t.string :city
      t.string :country
      t.integer :pincode
      t.timestamps
    end
  end
end
