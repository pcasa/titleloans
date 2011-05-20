class CreatePhones < ActiveRecord::Migration
  def self.up
    create_table :phones do |t|
      t.string :phone_number
      t.string :phone_type
      t.integer :customer_id
      t.boolean :disabled, :default => false
      t.timestamps
    end
    add_index(:phones, [:customer_id, :phone_type, :disabled], :unique => false, :name => "add_index_phones_ci_pt_d")
  end

  def self.down
    drop_table :phones
  end
end
