class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :encrypted_password, :string, :limit => 128,  :null => false
    add_column :users, :password_salt, :string, :limit => 255,  :null => false
    add_column :users, :reset_password_token, :string, :limit => 255
    add_column :users, :remember_token, :string, :limit => 255
    add_column :users, :remember_created_at, :datetime
    add_column :users, :sign_in_count, :integer, :default => 0
    add_column :users, :current_sign_in_at, :datetime
    add_column :users, :last_sign_in_at, :datetime
    add_column :users, :current_sign_in_ip, :string, :limit => 255
    add_column :users, :last_sign_in_ip, :string, :limit => 255
    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
  end

  def self.down
    remove_column :users, :encrypted_password
    remove_column :users, :password_salt
    remove_column :users, :reset_password_token
    remove_column :users, :remember_token
    remove_column :users, :remember_created_at
    remove_column :users, :sign_in_count
    remove_column :users, :current_sign_in_at
    remove_column :users, :last_sign_in_at
    remove_column :users, :current_sign_in_ip
    remove_column :users, :last_sign_in_ip
    remove_index :users, :email
    remove_index :users, :reset_password_token
  end
end
