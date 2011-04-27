class CreateTitleLoans < ActiveRecord::Migration
  def self.up
    create_table :title_loans do |t|
      t.integer :customer_id
      t.integer :company_id
      t.string :vin, :limit => 128
      t.string :make, :limit => 128
      t.string :model, :limit => 128
      t.string :style, :limit => 128
      t.string :color, :limit => 128
      t.integer :year, :limit => 4
      t.timestamps
    end
  end

  def self.down
    drop_table :title_loans
  end
end
