# frozen_string_literal: true

class Finder
    #zoba
  BASE_URL = "https://api.spotify.com/v1/search?q="

  def call(name, type, auth_token)
    url = build_url(name,type)
    response = get_response(url, auth_token)
    get_result(response, type)
  end

  private
  
  def build_url(name, type)
    "#{BASE_URL}#{name}&type=#{type}&limit=1"
  end
  
  def get_response(url_adress, auth_token)
    HTTParty.get(url_adress, headers: { Authorization: "Bearer #{auth_token}" })
  end

  def get_result(item, type)
    item[type.pluralize]['items'].first['id'] if item[type.pluralize]['items'].present?
  end
end
