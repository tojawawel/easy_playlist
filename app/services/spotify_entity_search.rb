# frozen_string_literal: true

class SpotifyEntitySearch

  BASE_URL = 'https://api.spotify.com/v1/search?q='
  include ::NotSupportedCharacters

  def initialize(name, type, auth_token)
    @name = name
    @type = type
    @auth_token = auth_token
  end

  def call
    url = build_url
    response = JSON.parse(get_response(url).body, symbolize_names: true)
    get_result(response)
  end

  private

  attr_reader :name, :type, :auth_token

  def build_url
    parsed_name = name.gsub(/./) {|m| CHARACTERS_TO_SUBSTITUTE.fetch(m, m) }
    "#{BASE_URL}#{parsed_name}&type=#{type}&limit=1"
  end

  def get_response(url_adress)
    HTTParty.get(url_adress, headers: { Authorization: "Bearer #{auth_token}" })
  end

  def get_result(item)
    item[type.pluralize.to_sym][:items].first[:id] if item[type.pluralize.to_sym][:items].present?
  end

end
