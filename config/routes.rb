Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }

      namespace :api do
        namespace :v1 do

      resources :roles

      # Posts controller routes
      resources :posts, only: [:create, :index, :show, :destroy] do
        resources :likes
        resources :bookmarks
      end

      resources :users, only: [:index, :show]

    end
  end

  mount ActionCable.server => "/cable"

end
