class AddPeriods < ActiveRecord::Migration
  def self.up
    Period.create(period_name: "Daily", period_id: 0)
    Period.create(period_name: "Weekly", period_id: 1)
    Period.create(period_name: "Montly", period_id: 2)
    Period.create(period_name: "Quarterly", period_id: 3)
    Period.create(period_name: "Half-yearly", period_id: 4)
    Period.create(period_name: "Yearly", period_id: 5)
    # Period.create(period_name: "Daily")
    # Period.create(period_name: "Weekly")
    # Period.create(period_name: "Montly")
    # Period.create(period_name: "Quarterly")
    # Period.create(period_name: "Half-yearly")
    # Period.create(period_name: "Yearly")
  end

  def self.down
    Period.delete_all
  end
end
