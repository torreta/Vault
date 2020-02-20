class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.float :amount
      t.references :sender_account
      t.references :receiver_account
      t.references :sender
      t.references :receiver

      t.timestamps
    end
  end
end
