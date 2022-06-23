Rails.application.routes.draw do
  root 'home#index'
  post "/graphql", to: "graphql#execute"
  
  devise_for :users
  # mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
