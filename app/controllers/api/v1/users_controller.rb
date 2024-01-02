class Api::V1::UsersController < ApplicationController
    # include Socialization::Follower
    # include Socialization::Followable
      # skip_before_action :authenticate_user!, only: [:create]
      # before_action :authenticate_user, only: [:profile, :deposit]

    # GET /api/v1/users
    def index
      @users = User.all
      render json: @users, status: :ok
    end
  
     # GET /api/v1/users/:id
     def show
      @user = User.find(params[:id])
      render json: @user, status: :ok
    end
  
    # GET /users/new
    def new
      @user = User.new
    end
  
  
    # POST /users or /users.json
  def create
      @user = User.new(user_params)
  
      if params[:role].present?
          @user.assign_default_role(params[:role])
        end
    
      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
    
    
      # User profile management action
      def profile
        # Retrieve and display user profile information
        @user = current_user
      end
    
      # Deposit money into user wallet action
      def deposit
        amount = params[:amount].to_f
        if amount <= 0
          flash[:alert] = 'Invalid deposit amount'
          redirect_to profile_path
        else
          current_user.update(balance: current_user.balance + amount)
          flash[:notice] = 'Deposit successful!'
          redirect_to profile_path
        end
      end
  
       # DELETE /users/1 or /users/1.json
    def destroy
      @user.destroy
  
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  
    # def update_avatar
    #   # Find the current user (you might use a different way to find the user, e.g., authentication)
    #   user = User.find(params[:id])
  
    #   # Attach the uploaded avatar to the user
    #   if user.avatar.attach(params[:avatar])
    #     render json: { message: 'Avatar uploaded successfully' }
    #   else
    #     render json: { error: 'Failed to upload avatar' }, status: :unprocessable_entity
    #   end
    # end
  
    def follow
      user_to_follow = User.find(params[:user_id])
      @following = current_user
      if @following.follow!(user_to_follow)
        render json: { follower: @following }
      else
        render json: { error: 'Failed to follow this user.' }, status: :unprocessable_entity
      end
    end

    def unfollow
      user_to_unfollow = User.find(params[:user_id])
      
      @unfollowing = current_user
      if @unfollowing.unfollow!(user_to_unfollow)
        render json: { message: 'You have unfollowed this user.', unfollower: @unfollowing }
      else
        render json: { error: 'Failed to unfollow this user.' }, status: :unprocessable_entity
      end
    end
  
    def followers
      user = User.find(params[:user_id])
      @followers = user.followers(User)
      render json: @followers, status: :ok
    end
  
    def followees
      user = User.find(params[:user_id]) 
      @followees = user.followees(User)
      render json: @followees, status: :ok
    end
  
    def current_balance
      render json: { balance: current_user.balance }, status: :ok
    end
  
    # def purchased_contents
    #   purchases = current_user.purchases.includes(:purchased_item)
    #   contents = purchases.map(&:purchased_item)
    #   render json: contents, status: :ok
    # end
    
      private
    
      # Strong parameters for user registration
      def user_params
        params.require(:user).permit(:username, :email, :password, :role)
      end
  
    end
    