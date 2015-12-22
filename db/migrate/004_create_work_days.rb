class CreateWorkDays < ActiveRecord::Migration
  # def change
  #   create_table :work_days do |t|
  #     t.belongs_to :issue, index: true
  #     t.date :day
  #     t.float :spent_time
  #   end
  # end

  def self.up
    create_table :work_days do |t|
      t.column :issue_id, :integer, :null => false
      t.column :day, :date, :null => false
      t.column :spent_time, :float, :null => false
    end

  end

  def self.down
    drop_table :work_days
  end
end
