class AddPeriodToIssues < ActiveRecord::Migration
  def self.up
    add_column :issues, :period_id, :integer
  end

  def self.down
    remove_column :issues, :period_id
  end
end
