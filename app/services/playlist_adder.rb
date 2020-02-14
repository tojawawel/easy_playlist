# frozen_string_literal: true

class PlaylistAdder
  BASE_URL = "https://api.spotify.com/v1/playlists/"

  def self.add_to_playlist(name = 'Nonono', path = 'app/fixtures/songs.txt')
    playlist = playlist_id(name)
    songlist = list_of_tracks(path)
    url = build_url(playlist, songlist)
    add_tracks(url)
  end

  private
  
  def self.playlist_id(name)
    Finder.get_playlist(name)
  end

  def self.list_of_tracks(path, list_of_uris = [])
    File.open(path).each {|song_title| add_uri_to_list(song_title, list_of_uris) } 
    list_of_uris.join(',')
  end

  def self.add_uri_to_list(name, list)
    list << track_uri(name) if track_uri(name)
  end

  def self.track_uri(name)
    Finder.get_track(name)
  end

  def self.build_url(playlist_id, list_of_tracks)
    "#{BASE_URL}#{playlist_id}/tracks?uris=#{list_of_tracks}"
  end

  def self.token
    Rails.application.credentials.spotify[:authorization_token]
  end

  def self.add_tracks(url_adress)
    HTTParty.post(url_adress, headers: { Authorization: "Bearer #{token}" }
    )
  end

end
