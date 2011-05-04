class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :company_id
      t.integer :customer_id
      t.integer :title_loan_id
      t.decimal :loan_payment, :precision => 7, :scale => 2
      t.decimal :amount_paid, :precision => 7, :scale => 2
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
