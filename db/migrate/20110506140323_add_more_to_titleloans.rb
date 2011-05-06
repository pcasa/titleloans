class AddMoreToTitleloans < ActiveRecord::Migration
  def self.up
    add_column :title_loans, :base_amount, :decimal, :precision => 7, :scale => 2
    add_column :title_loans, :previous_balance, :decimal, :precision => 7, :scale => 2, :default => 0.00
  end

  def self.down
    remove_column :title_loans, :previous_balance
    remove_column :title_loans, :base_amount
  end
end
