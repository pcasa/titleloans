class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :street1, :limit => 128
      t.string :street2, :limit => 128
      t.string :city, :limit => 64
      t.string :state, :limit => 18
      t.string :zipcode, :limit => 10
      t.string :address_type
      t.string :addressable_type
      t.integer :addressable_id
      t.boolean :current
      t.string :full_address, :limit => 255
      t.timestamps
    end
    add_index :addresses, [:addressable_type, :addressable_id], :name => "add_index_to_addresses_type_and_id"
  end

  def self.down
    drop_table :addresses
  end
end
