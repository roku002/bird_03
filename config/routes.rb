Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'top#index'
  resources :users, only: %i[new create]
  resources :posts, only: %i[new index create show edit update destroy] do
    resources :likes, only: %i[create destroy]
    collection do
      get :likes
    end
  end
  resource :profile, only: %i[show edit update]
  resources :password_resets, only: %i[new create edit update]

  get 'bird', to: 'static#bird'
  get 'terms', to: 'static#terms'
  get 'policy', to: "static#policy"
  get 'contact', to: "static#contact"
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
