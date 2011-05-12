class AddCustomerNumberToCustomers < ActiveRecord::Migration
  def self.up
    add_column :customers, :customer_number, :string
  end

  def self.down
    remove_column :customers, :customer_number
  end
end
