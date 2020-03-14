Rails.application.routes.draw do
  root to: 'requests#new'

  resources :requests, only: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
