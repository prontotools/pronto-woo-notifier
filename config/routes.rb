Rails.application.routes.draw do
  get '/plugins/sync', to: 'plugins#sync'
  get '/sites/sync-all-plugins', to: 'sites#sync_all_plugins'
  resources :plugins
  resources :sites
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
