class LikesController < ApplicationController

  before_action :require_login

  def create
    like =  Like.new like_params
    unless current_user.likes_post? params[:like][:likeable_id]
      if like.save
        message =  "Item liked"
      end
    else
      message = "Item not liked - something went wrong"
    end
    flash[:success] = message
    redirect_to posts_path
  end

  def destroy
  end

  private 
    def like_params
      params.require(:like).permit(:user_id, :likeable_id, :likeable_type)
    end
end
