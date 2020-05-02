Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "homes#index"
  resources :import_files
  get 'add_songs', to: 'playlists#add_songs_to_playlist'
end
