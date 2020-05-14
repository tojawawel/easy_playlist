# frozen_string_literal: true
class SpotifyEntitySearch
  BASE_URL = "https://api.spotify.com/v1/search?q="

  def initialize(name, type, auth_token)
    @name = name 
    @type = type
    @auth_token = auth_token
  end

  def call
    url = build_url
    response = get_response(url)
    get_result(response)
  end

  private

  attr_reader :name, :type, :auth_token
  
  def build_url
    "#{BASE_URL}#{name}&type=#{type}&limit=1"
  end
  
  def get_response(url_adress)
    HTTParty.get(url_adress, headers: { Authorization: "Bearer #{auth_token}" })
  end

  def get_result(item)
    item[type.pluralize]['items'].first['id'] if item[type.pluralize]['items'].present?
  end
end
