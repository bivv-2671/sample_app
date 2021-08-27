Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root to: "home#index"

    get "about" , to:"home#about"

    get "sign-up", to:"users#new"
    post "sign-up", to:"users#create"

    resources :users, only: %i(new create)
  end
end
