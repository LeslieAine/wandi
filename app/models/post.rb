class Post < ApplicationRecord
    belongs_to :user, foreign_key: 'user_id'
    has_many :bookmarks
    has_many :likes
  
    has_one_attached :image
  
    # Validations
    validates :content, presence: true
  
  end
  