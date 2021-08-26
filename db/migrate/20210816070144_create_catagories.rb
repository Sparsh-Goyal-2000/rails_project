class CreateCatagories < ActiveRecord::Migration[6.1]
  def change
    create_table :catagories do |t|
      t.string :title
      t.references :parent
      t.timestamps
    end
  end
end
