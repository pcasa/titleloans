class AddMilageToTitleLoans < ActiveRecord::Migration
  def self.up
    add_column :title_loans, :milage, :string, :limit => 16
  end

  def self.down
    remove_column :title_loans, :milage
  end
end
