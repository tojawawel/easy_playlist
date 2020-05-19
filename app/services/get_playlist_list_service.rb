# frozen_string_literal: true

class GetPlaylistListService

  URL = 'https://api.spotify.com/v1/me/playlists?limit=50'

  def initialize(auth_token, user)
    @auth_token = auth_token
    @user = user
  end

  def call
    playlists_names
  end

  private

  attr_reader :auth_token, :user

  def playlists_names
    list = []
    playlists = JSON.parse(download_playlists.body, symbolize_names: true)[:items]
    
    playlists.each do |playlist|
      list << playlist[:name] if playlist[:owner][:id] == user.uid
    end
    list
  end

  def download_playlists
    HTTParty.get(URL, headers: { Authorization: "Bearer #{auth_token}" })
  end

end
