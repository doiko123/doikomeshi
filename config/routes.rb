Rails.application.routes.draw do
  scope :admins do
    get '/', to: 'admins/homes#index'

    scope :products do
      get '/', to: 'admins/products#index', as: :admins_products
      post '/', to: 'admins/products#create', as: :admins_create_product
      get '/new', to: 'admins/products#new', as: :admins_new_product
    end
  end

    get '/', to: 'pages#index'
    post '/sponsored', to: 'pages#sponsored'

  namespace :admins do
    resources :customers
  end
end