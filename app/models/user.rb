class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :recoverable, 
          :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

     # Validation
     validates :username, presence: true
     validates :email, presence: true, uniqueness: { case_sensitive: false }
    validates :balance, numericality: { greater_than_or_equal_to: 0 }


  has_many :posts, foreign_key: 'user_id'
  has_many :contents
  has_one :about, dependent: :destroy

  has_many :likes, foreign_key: :user_id # To track likes on posts
  has_many :bookmarks, foreign_key: :user_id # To track bookmarks on creator's posts

  has_many :notifications
  has_many :chats
  has_many :rooms, through: :chats
  # has_many :orders, dependent: :destroy
  has_many :purchases, dependent: :destroy

  acts_as_follower
  acts_as_followable

  # has_many :orders, foreign_key: :ordered_by_id, dependent: :destroy
  # has_many :accepted_orders, class_name: 'Order', foreign_key: :accepted_by_id, dependent: :nullify
  # has_many :rejected_orders, class_name: 'Order', foreign_key: :rejected_by_id, dependent: :nullify
  # has_many :made_orders, class_name: 'Order', foreign_key: 'user_id'
  # has_many :received_orders, class_name: 'Order', foreign_key: 'accepted_by_id'


  def deduct_balance(amount)
    update!(balance: balance - amount)
  end

  def add_balance(amount)
    update!(balance: balance + amount)
  end

  after_create :assign_default_role

  def assign_default_role
    # Check the 'role' attribute of the user and assign a role based on its value
    case self.role
    when 'creator'
      add_role(:creator)
    when 'client'
      add_role(:client)
    else
      # Default role if 'role' is not 'creator' or 'client'
      add_role(:client)
    end
  end

end
