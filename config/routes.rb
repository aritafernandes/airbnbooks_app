Rails.application.routes.draw do
  devise_for :users
  root to: "books#index"

  resources :books do
    resources :bookings, only: %i[new create]
    resources :reviews, only: %i[new create]
  end

  resources :bookings, only: [:destroy] do
    post "accept", to: "bookings#accept"
    post "decline", to: "bookings#decline"
  end

  get "/my_bookings", to: "bookings#my_bookings"
  get "/my_requests", to: "bookings#my_requests"
end
