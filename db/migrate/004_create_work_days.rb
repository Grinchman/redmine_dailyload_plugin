class CreateWorkDays < ActiveRecord::Migration
  def change
    create_table :work_days do |t|
      t.date :day
      t.integer :worktime
    end
  end
end
