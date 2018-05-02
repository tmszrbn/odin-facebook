class FriendshipRequestsController < ApplicationController

  def create
    debugger
    request = FriendshipRequest.new friendship_request_params
    return nil if current_user.friends_with? User.find(params[:friendship_request][:receiver_id])
    if request.save
      flash.now[:success] = "Friendship request sent"
    else
      flash.now[:error] = "Friendship request sent"
    end
  end

  def destroy
  end

  private
    def friendship_request_params
      params.require(:friendship_request).permit(:sender_id, :receiver_id)
    end
end
