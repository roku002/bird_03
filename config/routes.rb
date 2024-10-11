Rails.application.routes.draw do
  get 'contact/new'
  get 'contact/confirm'
  get 'contact/done'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'top#index'
  resources :users, only: %i[new create] do
    get 'post_list', on: :member
  end
  resources :posts, only: %i[new index create show edit update destroy] do
    collection do
      get :likes
    end
  end
  resources :boards, only: %i[new index create show edit update destroy] do
    resources :comments, only: %i[create edit update destroy], shallow: true
  end
  resources :likes, only: %i[create destroy]
  resource :profile, only: %i[show edit update]
  resources :password_resets, only: %i[new create edit update]
  resources :contacts, only: [:new, :create] do
    collection do
      post 'confirm'
      post 'back'
      get 'done'
    end
  end

  get 'bird', to: 'static#bird'
  get 'terms', to: 'static#terms'
  get 'policy', to: "static#policy"
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
