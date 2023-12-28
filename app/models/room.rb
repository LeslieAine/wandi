class Room < ApplicationRecord
    has_many :chats
    has_many :users, through: :chats
    has_many :notifications
  end
  