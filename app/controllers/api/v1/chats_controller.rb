class Api::V1::ChatsController < ApplicationController
    # before_action :authenticate_user
  
    def create
      room = Room.find_by(id: chat_params[:room_id])
    #   user = User.find(chat_params[:user_id])
      user = current_user
      chat = room.chats.build(content: chat_params[:content], user: user)
  
      if chat.save
        room.update(seen: false)
        broadcast_chat(chat)
        render json: { chat: chat }, status: :created
      else
        render json: { error: chat.errors.full_messages }
      end
    end
  
    private
  
    def broadcast_chat(chat)
      serialized_data = { chat: chat }
      ChatsChannel.broadcast_to chat.room, serialized_data
    end
  
    def chat_params
      params.require(:chat).permit(:content, :room_id, :user_id)
    end
  end
  