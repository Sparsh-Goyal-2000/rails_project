class AddAddressRefToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :addresses, :user, foreign_key: true
  end
end
