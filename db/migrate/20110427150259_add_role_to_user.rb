class AddRoleToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :roles, :string, :limit => 128
    add_index :users, :roles
  end

  def self.down
    remove_index :users, :roles
    remove_column :users, :roles
  end
end
