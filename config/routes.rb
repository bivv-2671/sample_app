Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root to: "home#index"

    get "about" , to:"home#about"
  end
end
