module WorkDayHelper
  def self.user_dailyload(user, period)

    workdays = Hash.new()

    issues = user.issues

    if issues != nil && issues.size > 0
      issues.each do |issue|

        start_day = issue.start_date
        time = issue.estimated_hours

      end
    end

  end
end
