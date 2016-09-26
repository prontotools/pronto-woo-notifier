Rails.application.routes.draw do
  root 'sites#index'

  get '/plugins/sync', to: 'plugins#sync'
  get '/sites/sync', to: 'sites#sync_all', as: "sites_sync"
  get '/sites/:id/sync', to: "sites#sync_each", as: "site_sync"
  get '/sites/api', to: "sites#api", as: "site_api"

  resources :plugins, only: [:index]
  resources :sites

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
