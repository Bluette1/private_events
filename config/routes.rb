Rails.application.routes.draw do
  root to: "events#index"
  resources :users, only: %i[new create show]
  get '/sign_in', to: 'sessions#new'
  get '/signed_in', to: 'sessions#show'
  post '/sign_in', to: 'sessions#create'
  delete '/sign_out', to: 'sessions#destroy'
  get '/sign_up', to: 'users#new'
  resources :events, only: %i[new create show index]
  get '/attend_events', to: 'events#show_existing_events'
  post '/attend_events', to: 'events#attend_events'
end
