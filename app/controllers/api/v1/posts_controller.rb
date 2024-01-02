    # app/controllers/posts_controller.rb

    class Api::V1::PostsController < ApplicationController
        # before_action :authenticate_user_from_token!
        # before_action :authenticate_user!, only: [:create]
        # before_action :authenticate_user!
        before_action :find_post, only: [:show, :destroy]
        # load_and_authorize_resource
        
        def index
            @posts = Post.includes(:user).with_attached_image.order(created_at: :desc)

            # @posts_with_images = @posts.map do |post|
            #     if post.image.attached?
            #         post.as_json.merge(image_url: url_for(post.image))
            #     else
            #         post.as_json.merge(image_url: nil)
            #     end
            # end

            render json: @posts.to_json(include: { user: { only: [:id, :username, :avatar] } })
          end
    
          def show
            @post = Post.includes(:user).find_by(id: params[:id])
    
            if @post
              render json: @post.to_json(include: { user: { only: [:id, :username, :avatar] } })
            else
              render json: { error: 'Post not found' }, status: :not_found
            end
          end

        # Create a new post (for users)
        def create
            
            @user = current_user
            # @user = User.find(params[:user_id])

        if @user.nil?
            render json: { error: 'User not found' }, status: :unprocessable_entity
            # render json: current_user, status: :unprocessable_entity

        else


        @post = @user.posts.build(post_params)
        if @post.save
            render json: @post, status: :created
        else
            render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
        end
        end
    end

        # DELETE /api/v1/posts/:id
    def destroy
        if current_user? && @post.user == current_user
        @post.destroy
        render json: { message: 'Post deleted successfully' }
        else
        render json: { error: 'You are not authorized to delete this post' }, status: :forbidden
        end
    end
    
        private
    
        # Strong parameters for post creation

        # Find the post by ID
    def find_post
        @post = Post.find(params[:id])
    end
    
    def post_params
        params.require(:post).permit(:content, :user_id, :image)
    end

    # def authenticate_user_from_token!
    #     token = request.headers['Authorization']&.split(' ')&.last
    #     decoded_token = JWT.decode(token, Devise::JWT.secret_key, true, algorithm: Devise::JWT::Config.algorithm)
    
    #     user_id = decoded_token[0]['sub']
    #     @current_user = User.find(user_id) if user_id
    #     head :unauthorized unless @current_user
    #   rescue JWT::DecodeError
    #     head :unauthorized
    #   end
    
    end
    