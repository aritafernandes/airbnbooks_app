Rails.application.routes.draw do
  devise_for :users
  root to: "books#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :books do
    resources :bookings, only: %i[new create]
  end

  resources :bookings, only: [:destroy] do
    post "accept", to: "bookings#accept"
    post "decline", to: "bookings#decline"
  end

  get "/my_listings", to: "bookings#my_listings"
  get "/my_bookings", to: "bookings#my_bookings"
end
