class Bookmark < ApplicationRecord
    # Associations
    belongs_to :user, class_name: 'User', foreign_key: 'user_id'
    belongs_to :post, class_name: 'Post', foreign_key: 'post_id'
  
    # Validations (You can add additional validations as needed)
    validates :user_id, presence: true
    validates :post_id, presence: true
 end
 