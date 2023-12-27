class Content < ApplicationRecord
    attr_accessor :isPaid
   # Associations
   belongs_to :user, foreign_key: 'user_id'
   has_many :orders
#    has_many :purchases, as: :purchased_item

#    serialize :purchases, Array

   # Validations
   validates :title, presence: true
   validates :description, presence: true
   validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
   validates :url, presence: true
end
