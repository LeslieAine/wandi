class Api::V1::LikesController < ApplicationController

    # before_action :authenticate_user
  
    def create
      @like = Like.create(user_id: current_user.id, post_id: params[:post_id].to_i)
      render json: @like #here's the json object that has this like in it.
    end
  
    def destroy
      @like = Like.find(params[:id])
      @like.destroy
    end
  
    def like_params
      params.permit(:user_id, :post_id)
    end
  end