class AddMultipleToTitleLoans < ActiveRecord::Migration
  def self.up
    add_column :title_loans, :closed_date, :datetime
    add_column :title_loans, :closed_by, :integer
    add_column :title_loans, :loan_amount, :decimal, :precision => 7, :scale => 2
    add_column :title_loans, :parent_id, :integer
    add_column :title_loans, :payments_made, :integer, :default => 0
  end

  def self.down
    remove_column :title_loans, :parent_id
    remove_column :title_loans, :loan_amount
    remove_column :title_loans, :closed_by
    remove_column :title_loans, :closed_date
    remove_column :title_loans, :payments_made
  end
end
