class Bank < ApplicationRecord
    has_many: :bank_accounts
    has_many :users, through: :bank_accounts
end
