class WorkDaysController < ApplicationController
  unloadable
  before_action :set_date

  def index
  end

  def set_date
    @users = User.all
    @projects = Project.all
    @issues = Issue.all

    if params[:viewmode].present?
    @viewmode = params[:viewmode].to_sym
    end

    @viewmode ||= :week_range

    if params[:firstday].present?
      @first_day = Date.parse(params[:firstday],"%Y-%m-%d")
    end

    @today ||= Date::today # <= Just use date today if it's not set already
    @first_day ||= Date::today

    @monday = @first_day.beginning_of_week
    @sunday = @first_day.end_of_week

    @monthstart = @first_day.beginning_of_month
    @monthend = @first_day.end_of_month

    @currentweek = @monday..@sunday
    @currentmonth = @monthstart..@monthend

    render index
  end

end
