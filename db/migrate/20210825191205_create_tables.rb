class CreateTables < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :number
      t.timestamps
    end

    create_table :people do |t|
      t.string :name
      t.timestamps
    end

    create_table :companies do |t|
      t.string :name
      t.timestamps
    end
  end
end
