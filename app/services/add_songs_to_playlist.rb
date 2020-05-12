# frozen_string_literal: true
class AddSongsToPlaylist
  BASE_URL = "https://api.spotify.com/v1/playlists/"

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
    SpotifyEntitySearch.new.call(playlist_name, 'playlist', token)
  end

  def create_songlist(list_of_songs = [])
    File.open(path).each {|song_title| add_song_to_list(song_title, list_of_songs) } 
    list_of_songs.join(',')
  end

  def add_song_to_list(song_name, list)
    track = find_track(song_name)
    list << track if track.present?
  end

  def find_track(song_name)
    id = SpotifyEntitySearch.new.call(song_name, 'track', token)
    "spotify:track:#{id}" unless id.nil?
  end

  def build_url(playlist_name, created_songlist)
    "#{BASE_URL}#{playlist_name}/tracks?uris=#{created_songlist}"
  end

  def add_tracks(url_adress)
    HTTParty.post(url_adress, headers: { Authorization: "Bearer #{token}" }
    )
  end

end
