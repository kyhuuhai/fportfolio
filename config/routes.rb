Rails.application.routes.draw do
  post "/rate" => "rater#create", as: "rate"
  devise_for :users, controllers: {omniauth_callbacks: "callbacks",
    registrations: "users"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope "(:locale)", locale: /en|vi|ja/ do
    root "static_pages#home"
    resources :projects do
      resources :participates
    end
    resources :users
    resources :blogs
    resources :news
    resources :likes
    resources :comments
    resources :contacts
    resources :categories
    resources :like_blogs
    resources :homes
    namespace :admin do
      root "static_pages#index", as: "root"
    end
    resources :messages
  end

  mount ActionCable.server => "/cable"
end
