Rails.application.routes.draw do
  root to: 'homes#top'
  get 'users/show'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get "users/show" => "users#show"
  get "users/index" => "users#index"
  resources :reservations
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
