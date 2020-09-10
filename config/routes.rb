Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  scope "(:locale)", locale: /en|vi/ do
    root "account#index"

    put "/manager/reports", to: "manager/reports#update"

    devise_for :users, controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations",
      passwords: "users/passwords",
      confirmations: "users/confirmations"
    }, skip: :omniauth_callbacks

    namespace :manager do
      get "/users/search", to: "users#search"
      resources :reports, only: %i(index show update)
      resources :users, only: %i(index show update)
    end

    resources :reports
    resources :account, only: %i(index edit update)
    resources :comments, only: :create
  end
end
