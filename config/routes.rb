Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    resources :books, only: %i(index show)
    resources :borrow_requests, only: %i(index show)

    namespace :admin do
      root "static_pages#home"
      resources :borrow_requests, only: %i(index show edit)
    end

    root "static_pages#home"
    get "/home", to: "static_pages#home"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"

    get "/signup", to: "users#new"
    post "/signup", to: "users#create"

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users
  end
end
