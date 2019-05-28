Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: '/api/v1/users', controllers: {
    registrations: 'api/v1/registrations',
    sessions: 'api/v1/sessions',
    passwords: 'api/v1/passwords'
  }

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      devise_scope :user do
        get :status, to: 'api#status'
        resource :user, only: %i[update show] do
          get :profile
        end

        resources :products, only: :index do
          resource :rate, only: :create
        end
      end
    end
  end
end
