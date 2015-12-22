# This file is a part of Redmine Checklists (redmine_checklists) plugin,
# issue checklists management plugin for Redmine
#
# Copyright (C) 2011-2015 Kirill Bezrukov
# http://www.redminecrm.com/
#
# redmine_checklists is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# redmine_checklists is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with redmine_checklists.  If not, see <http://www.gnu.org/licenses/>.

require_dependency 'issue'

module RedmineDailyload
  module IssuePatch

    def self.included(base) # :nodoc:
      base.extend(ClassMethods)

      # base.send(:include, InstanceMethods)

      base.class_eval do
        unloadable # Send unloadable so it will not be unloaded in development
          belongs_to :period, :class_name => Period, :foreign_key => 'period_id'
          has_many :work_days, :class_name => WorkDay, :foreign_key => 'work_day_id', dependent: :destroy

        #after_save :update_period_from_issue
      end
    end

    module ClassMethods
    end

    # module InstanceMethods
    #   # This will update the Period associated to the issue
    #   def update_period_from_issue(context)
    #     self.reload
    #     self.period_id = context[:params][:issue][:period_id]
    #     return true
    #   end
    #
    # end
  end
end


unless Issue.included_modules.include?(RedmineDailyload::IssuePatch)
  Issue.send(:include, RedmineDailyload::IssuePatch)
end
