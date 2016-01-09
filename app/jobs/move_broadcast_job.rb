class MoveBroadcastJob < ApplicationJob
  queue_as :default

  def perform(user)
    ActionCable.server.broadcast 'cell_channel', user
  end
end
