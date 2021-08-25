class AddPersonRefToAccount < ActiveRecord::Migration[6.1]
  def change
    add_reference :accounts, :common_account, polymorphic: true
  end
end
