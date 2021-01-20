# frozen_string_literal: true

class SonglistCreator

  def initialize(path, token, list_of_songs = [])
    @path = path
    @token = token
    @list_of_songs = list_of_songs
  end

  def call
    create_songlist
  end

  attr_reader :path, :token, :list_of_songs

  def create_songlist
    File.open(path).each { |song_title| add_song_to_list(song_title) }
    list_of_songs.join(',')
  end

  def add_song_to_list(song_name)
    track = find_track(song_name)
    list_of_songs << track if track.present?
  end

  def find_track(song_name)
    id = SpotifyEntitySearch.new(song_name, 'track', token).call
    "spotify:track:#{id}" unless id.nil?
  end

end
