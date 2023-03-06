Rails.application.routes.draw do
  root 'home#index'
  post "/graphql", to: "graphql#execute"
  
  devise_for :users

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
