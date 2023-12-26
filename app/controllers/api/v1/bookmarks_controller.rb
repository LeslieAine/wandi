class Api::V1::BookmarksController < ApplicationController

    def create
      @bookmark = Bookmark.create(user_id: current_user.id, post_id: params[:post_id].to_i)
      render json: @bookmark #here's the json object that has this bookmark in it.
    end
  
    def destroy
      @bookmark = Bookmark.find(params[:id])
      @bookmark.destroy
    end
  
    def bookmark_params
      params.permit(:user_id, :post_id)
    end
  end