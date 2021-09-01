Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root to: "home#index"

    get "about" , to:"home#about"

    get "sign-up", to:"users#new"
    post "sign-up", to:"users#create"

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    resources :users

    resources :account_activations, only: :edit
    resources :password_resets, only: [:new, :create, :edit, :update]
  end
end
