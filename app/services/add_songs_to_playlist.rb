# frozen_string_literal: true

class AddSongsToPlaylist

  BASE_URL = 'https://api.spotify.com/v1/playlists/'

  def initialize(playlist_name, path, token)
    @playlist_name = playlist_name
    @path = path
    @token = token
  end

  def call
    playlist = find_playlist
    songlist = create_songlist
    url = build_url(playlist, songlist)
    add_tracks(url)
  end

  private

  attr_reader :playlist_name, :path, :token

  def find_playlist
    SpotifyEntitySearch.new(playlist_name, 'playlist', token).call
  end

  def create_songlist
    SonglistCreator.new(path, token).call
  end

  def build_url(playlist_name, created_songlist)
    "#{BASE_URL}#{playlist_name}/tracks?uris=#{created_songlist}"
  end

  def add_tracks(url_adress)
    HTTParty.post(url_adress, headers: { Authorization: "Bearer #{token}" })
  end

end
