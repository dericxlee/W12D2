Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api, defaults: { format: :json } do
    resources :guests, only: [:index, :show] do
      resources :gifts, only: [:index, :show], shallow: true 
    end
    resources :parties, only: [:index, :show]

    resource :session, only: [:show, :create, :destroy]
  end

  post 'api/test', to:'application#test'
end