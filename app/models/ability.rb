# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    #
    user ||= User.new # Guest user (not logged in)

    if user.has_role?(:admin)
      can :manage, :all # Admins can manage all resources
    else
      can :read, :all # Everyone can read posts

      if user.has_role?(:creator)
        # puts "User has creator role"
        # if can? :create, Post
        #     puts "User can create a post"
        # else
        #     puts "User cannot create a post"
        # end
        can :create, Post, user_id: user.id # Creators can create posts
        # can :update, Post, user_id: user.id # Creators can update their own posts
        can :destroy, Post, user_id: user.id # Creators can delete their own posts
        can :create, Content, user_id: user.id # Creators can create content
      end
    end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
  end
end
