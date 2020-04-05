class AddToPlaylistJob < ApplicationJob
  queue_as :default

  def perform(token)
    sleep 15
    PlaylistAdder.new.call(token)
  end
end
