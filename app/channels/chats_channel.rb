class ChatsChannel < ApplicationCable::Channel
    def subscribed
      @room = Room.find_by(id: params[:room_id])
      stream_for @room
    end
  
    def received(data)
      serialized_data = ActiveModelSerializers::Adapter::Json.new(ChatSerializer.new(data)).serializable_hash
      ChatsChannel.broadcast_to @room, serialized_data
    end
  
    def unsubscribed
      # Any cleanup needed when channel is unsubscribed
    end
  
  end
  