class AddToPlaylistJob < ApplicationJob
  queue_as :default

  def perform(name,path,token)
    AddSongsToPlaylist.new.call(name,path,token)
  end
end
