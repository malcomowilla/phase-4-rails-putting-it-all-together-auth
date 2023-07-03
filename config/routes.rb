Rails.application.routes.draw do
  # resources :users 
      # resources :recipes

  
  post '/signup', to: 'users#create_users'
  get '/me', to: 'users#show'
  post '/login', to: 'users#create'
  delete '/logout', to: 'users#destroy'
  get '/recipes', to: 'recipes#index'
  post '/recipes', to: 'recipes#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
