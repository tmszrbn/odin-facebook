class FriendshipsController < ApplicationController

  def create
    return nil unless current_user.can_accept_friendship_request_from? User.find(params[:friendship][:friend_id])
    @friendship = Friendship.new friendship_params 
    if @friendship.save
    end
  end

  def destroy
  end

  private
    def friendship_params
      params.require(:friendship).permit(:user_id, :friend_id)
    end
end
