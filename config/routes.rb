Rails.application.routes.draw do
  scope path: '/api', :defaults => { :format => :jsonapi } do
    scope path: '/v1' do
      resources :employees
      resources :positions, only: [:index]
      resources :departments, only: [:index]
    end
  end
end
