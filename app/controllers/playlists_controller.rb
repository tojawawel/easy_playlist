class PlaylistsController < ApplicationController

  def add_songs_to_playlist
    AddToPlaylistJob.perform_later(auth_token)
    redirect_to root_path, notice: 'Post was successfully created.'
  end

  def auth_token
    EncryptionService.decrypt(current_user.token)
  end
end
