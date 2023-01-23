Rails.application.routes.draw do
  namespace :api, defaults: { format: :json} do
    resources :invoices, only: [:create, :show, :index, :update]
    
    resources :users, only: [:create]
    get '/users/confirm', to: 'users#confirm', as: 'confirm_users'
  end 
end
