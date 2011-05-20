class AddUserIdToCustomers < ActiveRecord::Migration
  def self.up
    add_column :customers, :user_id, :integer
    add_index :customers, :user_id
  end

  def self.down
    remove_index :customers, :user_id
    remove_column :customers, :user_id
  end
end
