# frozen_string_literal: true

class Finder
  BASE_URL = "https://api.spotify.com/v1/search?q="

  def self.get_track(name, type = "track", identifier = "uri")
    url = build_url(name,type)
    track = response(url)
    get_result(track, type, identifier)
  end

  def self.get_playlist(name, type = "playlist", identifier = "id")
    url = build_url(name,type)
    playlist = response(url)
    get_result(playlist, type, identifier)
  end

  private
  
  def self.build_url(name,type)
    "#{BASE_URL}#{name}&type=#{type}&limit=1"
  end
  
  def self.response(url_adress)
    HTTParty.get(url_adress, headers: { Authorization: "Bearer #{token}" })
  end
  
  def self.token
    Rails.application.credentials.spotify[:authorization_token]
  end

  def self.get_result(item_type ,type, identifier)
    item_type[type.pluralize]['items'].first[identifier] if item_type[type.pluralize]['items'].present?
  end
end
