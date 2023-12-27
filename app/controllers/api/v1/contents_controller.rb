class Api::V1::ContentsController < ApplicationController
    # before_action :authenticate_user, except: [:index, :show]
    before_action :find_content, only: [:show]
  
    # Display a list of all available content
    def index
      @contents = Content.includes(:user).order(created_at: :desc)
      render json: @contents.to_json(include: { user: { only: [:id, :username, :avatar] } })
    end
  
    # Show details of a specific content item
    def show
        # @content = Content.find(params[:id])
        @content = Content.includes(:user).find_by(id: params[:id])
        if @content
            render json: @content.to_json(include: { user: { only: [:id, :username, :avatar] } })
          else
            render json: { error: 'Content not found' }, status: :not_found
          end
    end

    def user_content
      user_id = params[:user_id] || params[:id]
      user = User.find_by(id: user_id)
    
      if user
        @contents = user.contents.includes(:user, purchases: :user).order(created_at: :desc)
        render json: @contents.to_json(
          include: {
            # user: { only: [:id, :username, :avatar] },
            purchases: { only: [:id, :amount, :created_at] }
          }
        )
      else
        render json: { error: 'User not found' }, status: :not_found
      end
    end

  
    # user's action: Create new content
    def create
        @user = current_user

        if @user.nil?
            render json: { error: 'User not found' }, status: :unprocessable_entity
        else


        @content = @user.contents.build(content_params)
        if @content.save
            render json: @content, status: :created
        else
            render json: { errors: @content.errors.full_messages }, status: :unprocessable_entity
        end
        end
    end

    private
  
    # Strong parameters for content creation
    def content_params
      params.require(:content).permit(:title, :description, :price, :url, :user_id, :isPaid)
    end
  
    # Find content by ID for show action
    def find_content
      @content = Content.find(params[:id])
    end
  end
  