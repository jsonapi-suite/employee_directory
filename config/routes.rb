Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  scope path: '/api' do
    scope path: '/v1' do
      resources :employees
      resources :positions, only: [:index]
      resources :departments, only: [:index]
    end
  end
end
