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

module RedmineDailyload
  module Hooks
    class ViewsIssuesHook < Redmine::Hook::ViewListener

      def view_issues_show_details_bottom(context = { })
        if context[:issue]
          # return "<tr><td><b>Periodicity!!!:</b></td><td> #{context[:issue][:period_id]}</td></tr>"
          begin
            period = Period.find_by(period_id: context[:issue][:period_id])
          rescue RecordNotFound
              return "<tr><td><b>NO period:</b></td><td>"
          ensure
              return "<tr><td><b>Periodicity:</b></td><td> #{period.period_name unless period.nil?}</td></tr>"
          end
        else
          return "<tr><td><b>:((((((((</b></td><td>"
        end
      end

      # Renders a drop down containing the possible 'on days'
      #
      # Context
      # * :project => project for the issue
      # * :issue => Issue being created/editted
      #
      def view_issues_form_details_bottom(context = { })
        select = context[:form].select :period_id, PeriodsHelper.periods_for_select, :include_blank => true
        return "<p>#{select}</p>"
      end


      def set_period_on_issue(context)
        if context[:params] && context[:params][:issue] && context[:params][:issue][:period_id].present?
          context[:issue].period_id = context[:params][:issue][:period_id]
              # Period.find_by(period_name: context[:params][:issue][:period_id])
              #Period.find(context[:params][:issue][:work_period])
        end
        return ''
      end

      def controller_issues_new_before_save(context = {})
        set_period_on_issue(context)
      end

      def controller_issues_edit_before_save(context = {})
        set_period_on_issue(context)
      end

      # # Saves the Deliverable assignment to the issue
      # #
      # # Context:
      # # * :issue => Issue being saved
      # # * :params => HTML parameters
      # #
      # def controller_issues_bulk_edit_before_save(context = { })
      #   case true
      #
      #     when context[:params][:period_id].blank?
      #       # Do nothing
      #     when context[:params][:period_id] == 'none'
      #       # Unassign deliverable
      #       context[:issue].period = nil
      #     else
      #       context[:issue].period = Period.find(context[:params][:period_id])
      #   end
      #
      #   return ''
      # end
    end
  end
end
