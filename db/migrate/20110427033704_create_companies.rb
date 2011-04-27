class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name
      t.string :cached_slug
      t.string :phone, :limit => 128
      t.string :street1, :limit => 128
      t.string :street2, :limit => 128
      t.string :city, :limit => 64
      t.string :state, :limit => 32
      t.string :zipcode, :limit => 32
      t.string :full_address, :limit => 255
      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
