# encoding: utf-8
#
# This file is a part of Redmine Dailyload (redmine_dailyload) plugin,
# issue daily load for Redmine
#
# Copyright (C) 2015 Ivan Chupakhin
# http://www.almalence.com/
#
# redmine_dailyload is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# redmine_dailyload is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with redmine_dailyload.  If not, see <http://www.gnu.org/licenses/>.

module PeriodsHelper

  def self.periods_for_select
    Period.all.collect { |m| [m.period_name, m.period_id] }
  end

end
