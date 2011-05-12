class AddMultipleToDifferentModels < ActiveRecord::Migration
  def self.up
    add_column :customers, :company_id, :integer
    add_index :customers, :company_id
    add_index :orders, :company_id
    add_index :title_loans, :company_id
  end

  def self.down
    remove_index :customers, :company_id
    remove_index :orders, :company_id
    remove_index :title_loans, :company_id
    remove_column :customers, :company_id
  end
end
