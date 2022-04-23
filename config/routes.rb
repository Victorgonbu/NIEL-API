Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  default_url_options :host => "localhost:3000"
  namespace :api, defaults: {format: :json}, path: '/api' do
    namespace :v1, defaults: {format: :json}, path: '/v1' do
      root to: 'indexes#index' 
      resources :indexes, only: [:index]
      resources :users, only: [:create]
      resources :authenticate, only:[:create]
      resources :genres, only: [:index, :show], param: :slug

      resources :tracks, only: [:create, :update, :show, :index]
      resources :licenses, only: [:create, :show, :index, :update]
      resources :authentication, only: [:create]

      resource :direct_upload, only: [:create, :destroy]

    end
  end
end
