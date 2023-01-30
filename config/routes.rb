Rails.application.routes.draw do
  devise_for :chefs, controllers: {registrations: "chefs/registrations", sessions: "chefs/sessions"}

  root "pages#home"
  get "pages/home", to: "pages#home"

  get "search", controller: :pages

  resources :recipes do
    resources :comments, only: [:create] # nested route

    member do
      post "like"
    end
  end

  resources :chefs, only: [:index, :show]
  resources :ingredients, except: [:destroy]

  mount ActionCable.server => "/cable"

  get "/chat", to: "chatrooms#show"

  resources :messages, only: [:create]
end
