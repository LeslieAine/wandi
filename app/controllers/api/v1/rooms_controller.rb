class Api::V1::RoomsController < ApplicationController
    def index
        user = current_user
        rooms = user.rooms.uniq.sort_by { |room| room.updated_at }.reverse
        render json: rooms

    #   user = current_user
    #   rooms = user.rooms.uniq { |c| c.id }.sort_by &:updated_at
    #   render json: rooms.reverse
    end
  
    def create
      user = current_user
      reciever = User.find_by(email: params[:email])
  
      if reciever && reciever.id != user.id
        existing_room_array = user.rooms.select { |c| c.users.pluck(:id).include?(reciever.id) }
        room = user.rooms.build
  
        if existing_room_array.size > 0
          existing_room = existing_room_array[0]
          chat = existing_room.chats.create(content: params[:chat], user: user)
          broadcast_room(existing_room)
  
          render json: { room: existing_room }
        elsif room.save
          room.users << reciever
          notification = reciever.notifications.build(room: room, content: "You have a new chat from #{user.username}")
          notification.save
          chat = room.chats.create(content: params[:chat], user: user)
          broadcast_room(room)
  
          render json: { room: room }, status: :created
        end
      elsif reciever
        render json: { errors: "You cannot start a room with yourself" }
      else
        render json: { errors: "No user found" }
      end
    end
  
    def show
      room = Room.find_by(id: params[:id])
      render json: { room: room }
    end
  
    def update
      room = Room.find(params[:id])
      room.update(seen: true)
      render json: { room: room }
    end
  
    private
  
    def broadcast_room(room)
      ActionCable.server.broadcast 'rooms_channel', { room: room }
    end
  end
  