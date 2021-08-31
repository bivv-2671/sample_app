Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root to: "home#index"

    get "about" , to:"home#about"

    get "sign-up", to:"registers#new"
    post "sign-up", to:"registers#create"
  end
end
