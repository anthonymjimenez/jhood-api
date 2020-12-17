Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      # get '/snails/:id', to: 'snails#show', as: 'snail', param: :name
      resources :stocks
      resources :users, only: [:create, :update, :destroy, :index]
      resources :user_owned_stocks, only: [:create, :update, :destroy]
      post '/stocklist', to: "stocks#stock_list"
      put '/sellstock', to: "user_owned_stocks#sell_stock"
      put '/buystock', to: 'user_owned_stocks#buy_stock'
      put '/updatebalance', to: 'users#update_balance'
      post '/login', to: 'sessions#create'
      post '/auto_login', to: 'sessions#auto_login'
      delete '/logout', to: 'sessions#destroy'
    
    end
  end
end
