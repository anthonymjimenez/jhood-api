Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      # get '/snails/:id', to: 'snails#show', as: 'snail', param: :name
      resources :stocks
      resources :users, only: [:create, :update, :destroy, :index]
      resources :user_owned_stocks, only: [:create, :update, :destroy]
      
      post '/login', to: 'sessions#create'
      get '/auto_login', to: 'sessions#auto_login'
      delete '/logout', to: 'sessions#destroy'
    
    end
  end
end
