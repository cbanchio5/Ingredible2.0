Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'pages#home'
  get '/user' => "recipes#index", :as => :user_root
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users do
    resources :favourites, only: [:index, :show, :destroy]
    resources :memberships, only: [:index, :show, :destroy]
  end


  resources :recipes do
    collection do
      get :myrecipes
    end
    resources :favourites, only: [:new, :create, :index]

    resources :reviews, only: [ :new, :create, :index, :destroy ]
  end

  resources :communities do

    resources :messages, except: [:destroy]
    resources :memberships

  end

  # resources :memberships, only: [] do
  #   collection do
  #     get :mymemberships
  #   end
  # end

  resources :messages, only: [:destroy]

end
