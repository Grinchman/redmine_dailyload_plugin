module WorkDayHelper
  def self.user_dailyload(user_issues, period)

    # # logger = Logger.new(Rails.root.join("log", "production.log"), local: true)
    #
    # # user_load = Array.new(2){Hash.new(0)}
    # all_days  = Hash.new(0) # Stores all work days for user and work hours for appropriate days
    # # work_days = Hash.new(0) # The same as above but it 'period' interval (at some week or month)
    #
    # issues = Issue.where(assigned_to_id: user.id).all
    #
    # Rails.logger.info issues.inspect
    #
    # if issues != nil && issues.size > 0
    #   # Iterate all issues for user
    #   issues.each do |issue|
    #
    #     start_day = issue.start_date
    #     time = issue.estimated_hours
    #     Rails.logger.info "---------------------- ISSUE ESTIMATED TIME = " + time.to_s
    #     # We may calculate work load only if estimated time for that issue is presents
    #     unless time.nil?
    #
    #       full_days_count = (time.to_i)/8               # Count of 8-hours work days
    #       Rails.logger.info "---------------------- ISSUE FULL DAYS COUNT = " + full_days_count.to_s
    #       due_day = start_day + full_days_count  # Last days of full load work days
    #       full_days = start_day..due_day         # 8-hours work days interval
    #
    #       # Add 8-hours work days to hash
    #       full_days.each do |day|
    #         all_days[day] += 8
    #       end
    #
    #       part_time = time%8
    #       Rails.logger.info "---------------------- ISSUE PART TIME = " + part_time.to_s
    #       Rails.logger.info "---------------------- DUE_DAY + 1 = " + (due_day + 1).to_s
    #       all_days[due_day + 1] += part_time
    #
    #     end
    #
    #   end
    #
    #   return all_days
    #

    Rails.logger.info "---------------------- ALL WORK DAYS  = " + WorkDay.all.inspect + "\n"
    all_days  = Hash.new(0) # Stores all work days for user and work hours for appropriate days
    if user_issues != nil && user_issues.size > 0
      #   # Iterate all issues for user
      user_issues.each do |issue|
        work_days = WorkDay.where(day: period, issue_id: issue.id).all #.select{|work_day| period.cover?(work_day.day)}
        Rails.logger.info "---------------------- WORK DAYS  = " + work_days.inspect + "\n"
        work_days.each do |work_day|
          Rails.logger.info "---------------------- DAY  = " + work_day.inspect + "\n"
          all_days[work_day.day] += work_day.spent_time
        end
        Rails.logger.info "---------------------- ALL DAYS  = " + all_days.inspect + "\n"
      end
    end

    return all_days

  end

  def self.issue_daily_load(context)

    Rails.logger.info "---------------------- ALL WORK DAYS  = " + WorkDay.all.inspect + "\n"

    if context[:params] && context[:params][:issue] && context[:params][:issue][:period_id].present?
      period_id = context[:params][:issue][:period_id]
    end

    if context[:params] && context[:params][:issue] && context[:params][:issue][:start_date].present?
      start_date = context[:params][:issue][:start_date]
    end

    if context[:params] && context[:params][:issue] && context[:params][:issue][:due_date].present?
      due_date = context[:params][:issue][:due_date]
    end

    if context[:params] && context[:params][:issue] && context[:params][:issue][:estimated_hours].present?
      estimated_hours = context[:params][:issue][:estimated_hours]
    end

    # It's possible to calculate daily load only if start date and estimated hours is presented in issue
    if !start_date.nil? && !estimated_hours.nil?
      daily_load_possible = true
    else
      daily_load_possible = false
    end

    # Rails.logger.info "\n---------------------- ISSUE DAILY LOAD ----------------------\n"
    # unless issue.nil?
    #   Rails.logger.info 'Issue: ' + issue.inspect + "\n"
    # end
    # unless period_id.nil?
    #   Rails.logger.info('period_id (period name): ' + period_id + ' (' + Period.where(period_id: period_id).first.period_name + ")\n")
    # end
    unless start_date.nil?
      Rails.logger.info 'start_date: ' + start_date.inspect + "\n"
    end
    # unless due_date.nil?
    #   Rails.logger.info 'due_data: ' + due_date + "\n"
    # end
    # unless estimated_hours.nil?
    #   Rails.logger.info 'estimated_hours: ' + estimated_hours + "\n"
    # end

    return nil if !daily_load_possible # If not full data presents in issue

    issue_id = context[:params][:id]

    full_days_count = (estimated_hours.to_i)/8              # Count of 8-hours work days
    # Rails.logger.info "---------------------- ISSUE FULL DAYS COUNT = " + full_days_count.to_s + "\n"
    due_day = Date.parse(start_date) + (full_days_count - 1)  # Last day of full load work days
    # Rails.logger.info due_day.inspect + "\n"
    full_days = Date.parse(start_date)..due_day         # 8-hours work days interval
    # Rails.logger.info due_day.class.name + "\n"

    old_days = WorkDay.where(issue_id: issue_id).all
    Rails.logger.info "----------------------- OLD DAYS = " + old_days.inspect + "\n"

    # Add 8-hours work days to hash
    full_days.each do |day|
      # old_days = WorkDay.where(day: day, issue_id: issue_id).all
      work_day = WorkDay.new
      work_day.issue_id = issue_id
      work_day.day = day
      work_day.spent_time = 8
      work_day.day = day
      work_day.spent_time = 8
      if work_day.save
        Rails.logger.info "---------------------- WORK DAY SAVED = " + work_day.inspect + "\n"

        # Rails.logger.info "----------------------- ALL work days before clean = " + WorkDay.where(day: day, issue_id: issue_id).all.inspect + "\n"
        # # Remove old days
        # if !old_days.nil? && old_days.size > 0
        #   old_days.each do |old_day|
        #     old_day.destroy
        #   end
        # end

        # Rails.logger.info "----------------------- New work days = " + WorkDay.where(day: day, issue_id: issue_id).all.inspect + "\n"

      # else
      #   Rails.logger.info "---------------------- WORK DAY NOT SAVED\n"
      end
    end

    part_time = (estimated_hours.to_i)%8
    work_day2 = WorkDay.new
    work_day2.issue_id = issue_id
    work_day2.day = due_day + 1
    work_day2.spent_time = part_time

    if work_day2.save

      # WorkDay.where(day: due_day + 1, issue_id: issue_id).all.each do |old_day|
      #   old_day.destroy
      # end
      # Rails.logger.info "---------------------- WORK DAY (PART_TIME) = " + work_day2.inspect + "\n"
    # else
      # Rails.logger.info "---------------------- WORK DAY (PART_TIME) NOT SAVED\n"
    end



    Rails.logger.info "----------------------- ALL work days before clean = " + WorkDay.where(issue_id: issue_id).all.inspect + "\n"
    # Remove old days
    if !old_days.nil? && old_days.size > 0
      old_days.each do |old_day|
        old_day.destroy
      end
    end

    Rails.logger.info "----------------------- NEW DAYS = " + WorkDay.where(issue_id: issue_id).all.inspect + "\n"

  end
end
