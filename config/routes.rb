Rails.application.routes.draw do
  devise_for :users
  root to: "books#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :books, only: [:index, :new, :create, :show]
end
