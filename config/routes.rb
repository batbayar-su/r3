# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
get '/projects/:project_id/reason_documentation', :to => 'reason_documentation#index', :as => 'reason_documentation'
get '/projects/:project_id/reason_documentation/history', :to => 'reason_documentation#history', :as => 'reason_documentation_history'