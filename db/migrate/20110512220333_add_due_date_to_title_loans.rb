class AddDueDateToTitleLoans < ActiveRecord::Migration
  def self.up
    add_column :title_loans, :due_date, :date
  end

  def self.down
    remove_column :title_loans, :due_date
  end
end
