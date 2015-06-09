Rails.application.routes.draw do

  root to: 'root#index'

  devise_for :users

  resources :invoices, only: [:index, :show] do
    collection do
      put :synchronize
      get :synchronize if Rails.env.development?
    end
  end

end
