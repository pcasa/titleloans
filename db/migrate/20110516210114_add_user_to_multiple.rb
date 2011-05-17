class AddUserToMultiple < ActiveRecord::Migration
  def self.up
    add_column :title_loans, :user_id, :integer
    add_column :orders, :user_id, :integer
  end

  def self.down
    remove_column :title_loans, :user_id
    remove_column :orders, :user_id
  end
end
