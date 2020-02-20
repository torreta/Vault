class BankAccount < ApplicationRecord
  belongs_to :bank
  belongs_to :user
  has_many :sent_transactions, :class_name => 'Transaction', :foreign_key => 'sender_account_id'
  has_many :received_transactions, :class_name => 'Transaction', :foreign_key => 'receiver_acount_id'
end
