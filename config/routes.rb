Rails.application.routes.draw do
  root to: 'requests#new'

  resources :requests, only: [:create]

  scope 'request' do
    resources :confirmations, only: [:new, :create] do
      collection do
        get :confirmation
      end
    end
  end
end
