class Transaction < ApplicationRecord
  belongs_to :sender_account
  belongs_to :receiver_account
  belongs_to :sender
  belongs_to :receiver
end
