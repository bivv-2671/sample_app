Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root to: "home#index"

    get "about" , to:"home#about"

    get "sign-up", to:"users#new"
    post "sign-up", to:"users#create"
    get "show", to:"users#show"

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    resources :users, only: %i(new create show)
  end
end
