class PracticeMigration < ActiveRecord::Migration[6.1]
  def change
    change_column_default :products, :enabled, false
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
