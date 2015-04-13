require 'sidebar_hook'

Redmine::Plugin.register :redmine_reason_documentation do
  name 'Redmine Reason Documentation plugin'
  author 'Batbayar Sukhbaatar'
  description 'This is a plugin for Redmine'
  version '0.2.0'

  permission :reason_documentation, { :reason_documentation => [:index, :history] }, :public => true
  menu :project_menu, :reason_documentation, { :controller => 'reason_documentation', :action => 'index' }, :caption => 'Reason Report', :after => :settings, :param => :project_id
end
