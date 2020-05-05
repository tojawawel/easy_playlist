class AddToPlaylistJob < ApplicationJob
  queue_as :default

  def perform(name,path,token)
    PlaylistAdder.new.call(name,path,token)
  end
end
