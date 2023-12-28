class RoomsChannel < ApplicationCable::Channel
    def subscribed
      stream_from "rooms_channel"
    end
    def received(data)
      RoomsChannel.broadcast_to('rooms_channel')
    end
  
    def unsubscribed
      # Any cleanup needed when channel is unsubscribed
    end
  end
  