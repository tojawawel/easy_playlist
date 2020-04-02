class AddToPlaylistJob < ApplicationJob
  queue_as :default

  def perform(token)
    PlaylistAdder.new.call(token)
    sleep 5
  end
end
