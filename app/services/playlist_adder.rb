# frozen_string_literal: true

class PlaylistAdder
  BASE_URL = "https://api.spotify.com/v1/playlists/"

  def call(name, path, token) 
    playlist = find_playlist(name, token)
    songlist = create_songlist(path, token)
    url = build_url(playlist, songlist)
    add_tracks(url, token)
  end

  private

  def find_playlist(name, token)
    Finder.new.call(name, 'playlist', token)
  end

  def create_songlist(path, list_of_songs = [], token)
    File.open(path).each {|song_title| add_song_to_list(song_title, list_of_songs, token) } 
    list_of_songs.join(',')
  end

  def add_song_to_list(name, list, token)
    track = find_track(name, token)
    list << track if track.present?
  end

  def find_track(name, token)
    id = Finder.new.call(name, 'track', token)
    "spotify:track:#{id}" unless id.nil?
  end

  def build_url(playlist_name, created_songlist)
    "#{BASE_URL}#{playlist_name}/tracks?uris=#{created_songlist}"
  end

  def add_tracks(url_adress, token)
    HTTParty.post(url_adress, headers: { Authorization: "Bearer #{token}" }
    )
  end

end
