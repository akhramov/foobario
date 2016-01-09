# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class CellChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'cell_channel'
    current_user.move(current_user.position)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def move(position)
    current_user.move(position)
  end
end
