Rails.application.routes.draw do
  namespace :api, defaults: { format: :json} do
    resources :invoices, only: [:create, :show, :index, :update]
  end 
end
