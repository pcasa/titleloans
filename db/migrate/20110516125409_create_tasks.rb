class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.integer :user_id
      t.integer :assigned_to
      t.integer :completed_by
      t.string :name
      t.integer :asset_id
      t.string :asset_type
      t.string :category
      t.date :due_at
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :tasks, [:asset_id, :asset_type]
    add_index :tasks, :deleted_at
  end

  def self.down
    drop_table :tasks
  end
end
