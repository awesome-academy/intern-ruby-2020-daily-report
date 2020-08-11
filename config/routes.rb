Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "home#index"

    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
  end
end
