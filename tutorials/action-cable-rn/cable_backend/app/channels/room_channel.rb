class RoomChannel < ApplicationCable::Channel
  def subscribed
    room = params[:room]
    stream_from room
    ActionCable.server.broadcast room, { message: "A user has connected" }
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
