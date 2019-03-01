require 'byebug'
class MessagesController < ApplicationController
  def send
    ActionCable.server.broadcast 'test_room_channel', message: params[:message]
    render plain: "OK"
  end
end
