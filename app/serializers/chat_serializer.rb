class ChatSerializer < ActiveModel::Serializer
    # include JSONAPI::Serializer
    attributes :id, :content, :created_at, :user, :room, :room_id, :user_id
    def user
      user = object.user
    end
  
    def room
      room = object.room
    end
  end
  