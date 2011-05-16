class AddUsernameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :username, :string
    remove_column :users, :roles
    add_index :users, :username
  end

  def self.down
    remove_index :users, :username
    add_column :users, :roles, :string
    remove_column :users, :username
  end
end
