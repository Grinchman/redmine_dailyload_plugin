class CreatePeriods < ActiveRecord::Migration
  def self.up
    create_table :periods do |t|
      t.string :period_name
      t.integer :period_id
    end
  end

  def self.down
    drop_table :periods
  end
end
