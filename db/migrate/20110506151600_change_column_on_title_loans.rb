class ChangeColumnOnTitleLoans < ActiveRecord::Migration
  def self.up
    rename_column :title_loans, :model, :vin_model
  end

  def self.down
    rename_column :title_loans, :vin_model, :model
  end
end
