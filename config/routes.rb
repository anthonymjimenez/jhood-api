Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      # get '/snails/:id', to: 'snails#show', as: 'snail', param: :name
      resources :stocks

      resources :users, only: [:create, :update, :destroy]
      resources :user_owned_stocks, only: [:create, :update, :destroy]

    
    end
  end
end
