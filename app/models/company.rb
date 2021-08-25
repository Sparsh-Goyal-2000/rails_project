class Company < ApplicationRecord
  has_one :account, as: :common_account, dependent: :destroy
end