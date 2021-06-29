Rails.application.routes.draw do
  scope :admins do
    get '/', to: 'admins/homes#index'

    scope :products do
      get '/', to: 'admins/products#index', as: :admins_products
      post '/', to: 'admins/products#create', as: :admins_create_product
      get '/new', to: 'admins/products#new', as: :admins_new_product
    end
  end

    get '/', to: 'pages#index', as: :top_page
    post '/sponsored', to: 'pages#sponsored'
    get '/thanks', to: 'pages#thanks'

  namespace :admins do
    resources :customers
  end

  get '*unmatched_route', to: 'application#raise_not_found'
end