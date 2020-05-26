# frozen_string_literal: true

class SonglistCreator

  CHARACTERS_TO_SUBSTITUTE = {
    'ę' => 'e',
    'Ę' => 'E',
    'ó' => 'o',
    'Ó' => 'O',
    'ą' => 'a',
    'Ą' => 'A',
    'ś' => 's',
    'Ś' => 'S',
    'ł' => 'l',
    'Ł' => 'L',
    'ż' => 'z',
    'Ż' => 'Z',
    'ź' => 'z',
    'Ź' => 'Z',
    'ć' => 'c',
    'Ć' => 'C',
    'ń' => 'n',
    'Ń' => 'N'
  }.freeze

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
    parsed_name = song_name.gsub(/./) {|m| CHARACTERS_TO_SUBSTITUTE.fetch(m, m) }
    id = SpotifyEntitySearch.new(parsed_name, 'track', token).call
    "spotify:track:#{id}" unless id.nil?
  end

end
