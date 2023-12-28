class RoomSerializer < ActiveModel::Serializer
    # include JSONAPI::Serializer
    attributes :id, :chats, :users, :seen
  
    def chats
      chats = object.chats.uniq { |c| c.id }
      # object.chats.uniq { |c| c.id }
    end
  
    def users
      users = object.users.uniq { |c| c.id }
      # object.users.uniq { |c| c.id }
    end
  end
  