Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "homes#index"
  get 'add_songs', to: 'playlists#add_songs_to_playlist'
end
