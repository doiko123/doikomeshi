Rails.application.routes.draw do
  scope :admins do
    get '/', to: 'admins/homes#index'
  end
end