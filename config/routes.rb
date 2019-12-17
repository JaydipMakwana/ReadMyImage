Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :bucket_lists, except: %i[edit update]
  root to: 'bucket_lists#index'
end
