Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "account#index"

    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    put "/manager/reports", to: "manager/reports#update"

    namespace :manager do
      resources :reports
    end

    resources :reports, except: %i(show destroy)
    resources :account, only: %i(index edit)
  end
end
