class PracticeMigration2 < ActiveRecord::Migration[6.1]
  def up
    change_column_default :products, :price, 6
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
