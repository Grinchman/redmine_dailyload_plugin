# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
RedmineApp::Application.routes.draw do
  match 'work_days/(:action(/:id))',via: [:get], :controller => 'work_days'
  get 'work_days' => 'work_days_controller#index', as: :index_action
end
