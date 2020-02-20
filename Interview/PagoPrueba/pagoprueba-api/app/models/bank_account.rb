class BankAccount < ApplicationRecord
  belongs_to :bank
  belongs_to :user
end
