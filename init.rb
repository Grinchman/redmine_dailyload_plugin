require 'redmine_dailyload'

Redmine::Plugin.register :redmine_dailyload do
  name 'Dailyload plugin'
  author 'Ivan Chupakhin'
  description 'Adds daily working hours to issue'
  version '0.0.1'
  url 'http://almalence.com'
  author_url 'http://almalence.com'

  requires_redmine :version_or_higher => '3.1'

  project_module :dailyload do
    permission :dailyload, :public => true
  end

  menu :top_menu, :dailyload, { :controller => 'work_days', :action => 'index'}, :after => :projects, :caption => :label_workdays,
       :if =>  Proc.new { User.current.logged? }
end
