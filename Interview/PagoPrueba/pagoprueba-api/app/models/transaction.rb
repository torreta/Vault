class Transaction < ApplicationRecord
  belongs_to :sender_account, :class_name => 'BankAccount'
  belongs_to :receiver_account, :class_name => 'BankAccount'
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
end
