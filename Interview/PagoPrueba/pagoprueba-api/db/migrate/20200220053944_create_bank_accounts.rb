class CreateBankAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :bank_accounts do |t|
      t.float :amount
      t.integer :phone
      t.references :bank, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
