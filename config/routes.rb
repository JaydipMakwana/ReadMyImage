Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :images, except: %i[edit update] do
    get 'download_text'
  end
  root 'images#index'
end
