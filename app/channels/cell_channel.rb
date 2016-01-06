# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class CellChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'cell_channel'
    result = { mass: 3, position: { x: 5, y: 6 } }
    ActionCable.server.broadcast 'cell_channel', message: result
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def move(data)
    message = data['message'] || {}

    result = message
    ActionCable.server.broadcast 'cell_channel', message: result
  end
end
