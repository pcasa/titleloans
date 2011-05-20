class CreateTitleDocs < ActiveRecord::Migration
  def self.up
    create_table :title_docs do |t|
      t.integer :title_loan_id
      t.string :name
      t.string :f_name

      t.timestamps
    end
  end

  def self.down
    drop_table :title_docs
  end
end
