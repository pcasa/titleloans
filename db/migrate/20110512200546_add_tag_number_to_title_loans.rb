class AddTagNumberToTitleLoans < ActiveRecord::Migration
  def self.up
    add_column :title_loans, :tag_number, :string, :limit => 16
  end

  def self.down
    remove_column :title_loans, :tag_number
  end
end
