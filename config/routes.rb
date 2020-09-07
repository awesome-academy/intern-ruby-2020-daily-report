Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "account#index"

    put "/manager/reports", to: "manager/reports#update"

    devise_for :users, controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations",
      passwords: "users/passwords",
      confirmations: "users/confirmations"
    }

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
