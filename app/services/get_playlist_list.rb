# frozen_string_literal: true
class GetPlaylistList
  URL = "https://api.spotify.com/v1/me/playlists?limit=50"

  def playlists_names(auth_token, user)
    list = []
    playlists = download_playlists(auth_token)['items']

    playlists.each do |playlist|
      list << playlist['name'] if playlist['owner']['id'] == user.uid
    end
      list
  end


  def download_playlists(auth_token)
    HTTParty.get(URL, headers: { Authorization: "Bearer #{auth_token}" })
  end
end
