class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :street1
      t.string :street2
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :full_address
      t.timestamps
    end
  end

  def self.down
    drop_table :customers
  end
end
