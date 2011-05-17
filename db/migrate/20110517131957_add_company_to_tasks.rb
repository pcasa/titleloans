class AddCompanyToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :company_id, :integer
    add_index :tasks, [:company_id, :assigned_to]
  end

  def self.down
    remove_index :tasks, [:company_id, :assigned_to]
    remove_column :tasks, :company_id
  end
end
