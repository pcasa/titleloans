class AddMultipleToCustomers < ActiveRecord::Migration
  def self.up
    add_column :customers, :c_height, :string, :limit => 16
    add_column :customers, :gender, :string, :limit => 16
    add_column :customers, :race, :string, :limit => 64
    add_column :customers, :dob, :date
  end

  def self.down
    remove_column :customers, :dob
    remove_column :customers, :race
    remove_column :customers, :gender
    remove_column :customers, :c_height
  end
end
