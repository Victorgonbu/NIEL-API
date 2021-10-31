Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json}, path: '/api' do
    namespace :v1, defaults: {format: :json}, path: '/v1' do
      root to: 'indexes#index' 
      resources :indexes, only: [:index]
      resources :users, only: [:create]
      resources :authenticate, only:[:create]
      resources :genres, only: [:index, :show], param: :slug do
        resources :tracks, only: [:show, :index]
      end

      resources :tracks, only: [:create, :update]
      
      resources :authentication, only: [:create]
    end
  end
end
