Rails.application.routes.draw do
  resources :customers
  scope :admins do
    get '/', to: 'admins/homes#index'

    scope :products do
      get '/', to: 'admins/products#index', as: :admins_products
      post '/', to: 'admins/products#create', as: :admins_create_product
      get '/new', to: 'admins/products#new', as: :admins_new_product
    end
  end
end