class CreateEmploymentships < ActiveRecord::Migration
  def self.up
    create_table :employmentships do |t|
      t.integer :user_id
      t.integer :company_id

      t.timestamps
    end
  end

  def self.down
    drop_table :employmentships
  end
end
